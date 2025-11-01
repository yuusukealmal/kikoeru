use serde_json::json;

use crate::api::requests::{
    base::{http_get, http_post, http_put},
    config::types::{Env, LoginClass, SearchType, BASE_API, ORDERS, WORK_API},
};

pub async fn get_all_works(
    index: Option<u32>,
    subtitle: Option<u32>,
    order: Option<u32>,
) -> Result<String, String> {
    let order_type = &ORDERS[order.unwrap_or(1) as usize];
    let mut query = json!({
        "order":  order_type.order_name,
        "sort": order_type.sort.to_strings(),
        "page": index.unwrap_or(1),
        "subtitle": subtitle.unwrap_or(0),
    });

    if order_type.order_name == "rating" {
        // TODO
        query["withPlaylistStatus"] = json!([]);
    }
    if order_type.order_name == "random" {
        let rand = rand::random::<u32>().to_string();
        query["seed"] = json!(rand);

        query["subtitle"] = json!(subtitle.unwrap_or(0));
    }

    http_get(
        format!("{}/api/works", WORK_API),
        None,
        Some(query), // Some(true),
    )
    .await
}

pub async fn get_popular_works(
    index: Option<u32>,
    subtitle: Option<u32>,
) -> Result<String, String> {
    let body = json!({
        "keyword": " ",
        "page": index.unwrap_or(1),
        "subtitle": subtitle.unwrap_or(0),
        "localSubtitledWorks": [],
        // TODO
        "withPlaylistStatus": []
    });

    http_post(format!("{}/api/recommender/popular", WORK_API), None, body).await
}

pub async fn get_recommended_works(
    index: Option<u32>,
    subtitle: Option<u32>,
) -> Result<String, String> {
    let body = json!({
        "keyword": " ",
        // TODO
        "recommenderUuid": "",
        "page": index.unwrap_or(1),
        "subtitle": subtitle.unwrap_or(0),
        "localSubtitledWorks": [],
        // TODO
        "withPlaylistStatus": []
    });

    http_post(
        format!("{}/api/recommender/recommend-for-user", WORK_API),
        None,
        body,
    )
    .await
}

pub async fn get_favorite_works(index: Option<u32>) -> Result<String, String> {
    let query = json!({
        "order": "updated_at",
        "sort": "desc",
        "page": index.unwrap_or(1),
    });

    http_get(format!("{}/api/review", WORK_API), None, Some(query)).await
}

pub async fn get_work_track(id: String) -> Result<String, String> {
    let query = json!({
        "v":"1"
    });

    http_get(format!("{}/api/tracks/{}", WORK_API, id), None, Some(query)).await
}

pub async fn get_work_info(id: String) -> Result<String, String> {
    http_get(format!("{}/api/workInfo/{}", BASE_API, id), None, None).await
}

pub async fn get_search_works(
    search_type: SearchType,
    query: Option<String>,
    index: Option<u32>,
    subtitle: Option<u32>,
    order: Option<u32>,
) -> Result<String, String> {
    let mut params = query.unwrap_or(" ".into());
    params = search_type.to_params(params);

    let order_type = &ORDERS[order.unwrap_or(1) as usize];

    let query = json!({
        "order":order_type.order_name,
        "sort":order_type.sort.to_strings(),
        "page": index.unwrap_or(1),
        "subtitle":subtitle.unwrap_or(0),
        "includeTranslationWorks": "true",
    });

    http_get(
        format!("{}/api/search/{}", BASE_API, params),
        None,
        Some(query),
    )
    .await
}

pub async fn get_play_list() -> Result<String, String> {
    http_get(
        format!("{}/api/playlist/get-default-mark-target-playlist", BASE_API),
        None,
        None,
    )
    .await
}

pub async fn update_rate(id: String, rate: u32) -> Result<String, String> {
    let body = json!({
        "progress": None::<String>,
        "rating": rate,
        "review_text": None::<String>,
        "work_id": id,
    });

    http_put(format!("{}/api/review", WORK_API), None, body).await
}

pub async fn try_fetch_token(account: String, password: String) -> Result<Env, String> {
    let body = json!({
        "name": account,
        "password": password,
    });

    let response = http_post(format!("{}/api/auth/me", BASE_API), None, body).await;

    if let Err(e) = response {
        return Err(e.into());
    }

    let raw_auth = response.unwrap();
    let auth = serde_json::from_str::<serde_json::Value>(&raw_auth);
    if let Err(e) = auth {
        return Err(format!("{}\n{}", raw_auth, e));
    }

    let auth = auth.unwrap();
    if auth.get("user").is_none() || auth.get("token").is_none() {
        return Err("user or token is none".into());
    }

    let user_info = LoginClass::from_str(auth.to_string().as_str());

    if user_info.user.logged_in {
        return Ok(Env {
            recommender_uuid: user_info.user.recommender_uuid,
            token: user_info.token,
        });
    } else {
        return Err("login failed".into());
    }
}

use super::config::err::err_msg;
use super::config::utils::get_headers;
use crate::api::requests::config::types::AuthHeader;

pub async fn http_get(
    url: String,
    query: Option<serde_json::Value>,
    header: Option<AuthHeader>,
) -> Result<String, String> {
    let headers = get_headers(header.and_then(|h| h.token));
    let client = reqwest::Client::new();

    let res = client
        .get(&url)
        .headers(headers)
        .query(&query.unwrap_or(serde_json::Value::Null))
        .send()
        .await
        .unwrap();
    let status = res.status();
    let text = res.text().await.unwrap();

    match status {
        reqwest::StatusCode::OK => Ok(text),
        _ => Err(err_msg(&url, status.as_u16(), &format!("{}", status)).into()),
    }
}

pub async fn http_post(
    url: String,
    body: serde_json::Value,
    header: Option<AuthHeader>,
) -> Result<String, String> {
    let headers = get_headers(header.and_then(|h| h.token));
    let client = reqwest::Client::new();

    let res = client
        .post(&url)
        .headers(headers)
        .json(&body)
        .send()
        .await
        .unwrap();
    let status = res.status();
    let text = res.text().await.unwrap();

    match status {
        reqwest::StatusCode::OK => Ok(text),
        _ => {
            println!("{:?}", text);
            Err(err_msg(&url, status.as_u16(), &format!("{}", text)).into())
        }
    }
}

pub async fn http_put(
    url: String,
    body: serde_json::Value,
    header: Option<AuthHeader>,
) -> Result<String, String> {
    let headers = get_headers(header.and_then(|h| h.token));
    let client = reqwest::Client::new();

    let res = client
        .put(&url)
        .headers(headers)
        .json(&body)
        .send()
        .await
        .unwrap();
    let status = res.status();
    let text = res.text().await.unwrap();

    match status {
        reqwest::StatusCode::OK => Ok(text),
        _ => {
            println!("{:?}", text);
            Err(err_msg(&url, status.as_u16(), &format!("{}", text)).into())
        }
    }
}

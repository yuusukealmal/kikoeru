use std::collections::HashMap;

use super::config::err::err_msg;
use super::config::utils::{get_default_headers, merge_headers};

pub async fn http_get(
    url: String,
    header: Option<HashMap<String, String>>,
    query: Option<serde_json::Value>,
    // token_required: Option<bool>,
) -> Result<String, String> {
    let headers = if let Some(h) = header {
        merge_headers(h)
    } else {
        get_default_headers()
    };

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
    header: Option<HashMap<String, String>>,
    body: serde_json::Value,
) -> Result<String, String> {
    let headers = if let Some(h) = header {
        merge_headers(h)
    } else {
        get_default_headers()
    };

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
    header: Option<HashMap<String, String>>,
    body: serde_json::Value,
) -> Result<String, String> {
    let headers = if let Some(h) = header {
        merge_headers(h)
    } else {
        get_default_headers()
    };

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

use std::collections::HashMap;

use reqwest::header::{HeaderMap, HeaderName, HeaderValue};

pub fn get_headers(token: Option<String>) -> HeaderMap {
    let mut header = HeaderMap::new();

    header.insert("Content-Type", "application/json".parse().unwrap());
    header.insert(
        "User-Agent",
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko)"
            .parse()
            .unwrap(),
    );
    if let Some(t) = token {
        header.insert(
            HeaderName::from_bytes(b"Authorization").unwrap(),
            HeaderValue::from_str(&format!("Bearer {}", t)).unwrap(),
        );
    }

    header
}

pub fn query_to_string(query: &HashMap<String, String>) -> String {
    let mut query_string = String::new();

    for (key, value) in query {
        query_string.push_str(&format!("{}={}&", key, value));
    }

    query_string.pop();

    query_string
}

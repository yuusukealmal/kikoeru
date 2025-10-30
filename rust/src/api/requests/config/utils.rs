use std::collections::HashMap;

use reqwest::header::{HeaderMap, HeaderName, HeaderValue};

pub fn get_default_headers() -> HeaderMap {
    let mut header = HeaderMap::new();

    header.insert("Content-Type", "application/json".parse().unwrap());
    header.insert(
        "User-Agent",
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko)"
            .parse()
            .unwrap(),
    );
    header.insert(
        HeaderName::from_bytes(b"Authorization").unwrap(),
        // TODO
        HeaderValue::from_str("Bearer").unwrap(),
    );

    header
}

pub fn merge_headers(headers: HashMap<String, String>) -> HeaderMap {
    let mut default = get_default_headers();

    for (key, value) in headers {
        let name = HeaderName::from_bytes(key.as_bytes()).unwrap();
        let val = HeaderValue::from_str(&value).unwrap();

        default.insert(name, val);
    }

    default.insert(
        HeaderName::from_bytes(b"Authorization").unwrap(),
        // TODO
        HeaderValue::from_str("Bearer").unwrap(),
    );

    default
}

pub fn query_to_string(query: &HashMap<String, String>) -> String {
    let mut query_string = String::new();

    for (key, value) in query {
        query_string.push_str(&format!("{}={}&", key, value));
    }

    query_string.pop();

    query_string
}

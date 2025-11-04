pub const WORK_API: &str = "https://api.asmr-200.com";

pub const BASE_API: &str = "https://api.asmr.one";

#[derive(Clone)]
pub enum SortType {
    Asc,
    Dsc,
}

impl SortType {
    pub fn as_str(&self) -> &'static str {
        match self {
            SortType::Asc => "asc",
            SortType::Dsc => "desc",
        }
    }

    pub fn to_strings(&self) -> String {
        self.as_str().to_string()
    }
}

pub struct Orders {
    pub order_name: &'static str,
    pub sort: SortType,
}

pub const ORDERS: &[Orders] = &[
    Orders {
        order_name: "release",
        sort: SortType::Dsc,
    }, //發售日期倒序
    Orders {
        order_name: "create_date",
        sort: SortType::Dsc,
    }, //最新收錄
    Orders {
        order_name: "rating",
        sort: SortType::Dsc,
    }, //我的評價倒序
    Orders {
        order_name: "release",
        sort: SortType::Asc,
    }, //發售日期順序
    Orders {
        order_name: "dl_count",
        sort: SortType::Dsc,
    }, //銷量倒序
    Orders {
        order_name: "price",
        sort: SortType::Asc,
    }, //價格順序
    Orders {
        order_name: "price",
        sort: SortType::Dsc,
    }, //價格倒序
    Orders {
        order_name: "rate_average_2dp",
        sort: SortType::Dsc,
    }, //評價倒序
    Orders {
        order_name: "review_count",
        sort: SortType::Dsc,
    }, //評論數量倒序
    Orders {
        order_name: "id",
        sort: SortType::Dsc,
    }, //RJ號倒序
    Orders {
        order_name: "id",
        sort: SortType::Asc,
    }, //RJ號順序
    Orders {
        order_name: "nsfw",
        sort: SortType::Asc,
    }, //全年齡順序
    Orders {
        order_name: "random",
        sort: SortType::Dsc,
    }, //隨機
];

pub enum SearchType {
    String,
    Vas,
    Circle,
    Tag,
}

impl SearchType {
    pub fn to_params(&self, query: String) -> String {
        match self {
            SearchType::String => query,
            SearchType::Vas => format!("$va:{}$", query),
            SearchType::Circle => format!("$circle:{}$", query),
            SearchType::Tag => format!("$tag:{}s$", query),
        }
    }
}

pub struct User {
    pub logged_in: bool,
    pub name: String,
    pub group: String,
    pub email: Option<String>,
    pub recommender_uuid: String,
}

impl User {
    pub fn from_str(s: &str) -> Self {
        let json: serde_json::Value = serde_json::from_str(s).unwrap();
        let logged_in = json["loggedIn"].as_bool().unwrap().to_owned();
        let name = json["name"].as_str().unwrap().to_owned();
        let group = json["group"].as_str().unwrap().to_owned();
        let email = json["email"].as_str().map(|s| s.to_owned());
        let recommend_uuid = json["recommenderUuid"].as_str().unwrap().to_owned();
        Self {
            logged_in,
            name,
            group,
            email,
            recommender_uuid: recommend_uuid,
        }
    }
}

pub struct LoginClass {
    pub user: User,
    pub token: String,
}

impl LoginClass {
    pub fn from_str(s: &str) -> Self {
        let json: serde_json::Value = serde_json::from_str(s).unwrap();
        let user = json["user"].as_object().unwrap().clone();
        println!("{:?}", user);
        let token = json["token"].as_str().unwrap().to_string();
        Self {
            user: User::from_str(&serde_json::to_string(&user).unwrap()),
            token,
        }
    }
}

pub struct Env {
    pub recommender_uuid: String,
    pub token: String,
}

pub struct AuthHeader {
    pub recommender_uuid: Option<String>,
    pub playlist_id: Option<String>,
    pub token: Option<String>,
}

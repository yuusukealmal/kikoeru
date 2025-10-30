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

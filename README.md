# Coupon Practice
This is a practice with coupon

## Goal
- 訂單滿金額、滿件數、指定商品滿 X 元，折 Y 元、 Z %、免運費、送特定商品
- 特定供應商場品滿 X 件折 Y 元或 Z %
- 折扣可限定總共只套用 N 次或總共優惠 Y 元
- 折扣可限定每人只套用 N 次或總共優惠 Y 元
- 折扣可限制特定時間內有效
- 每月重新計算使用數量限制
- 訂單完成後寄送每人獨立的軟體序號

## Getting Started
* Ruby version: 2.6.3
* Rails version: 6.0.2.1
* Clone this project
* `$ bundle install`
* `$ rails db:create`
* `$ rails db:migrate`
* `$ rails server` 

## Table Schema

| User     |        |
| -------- | ------ |
| id       | Text   |
| name     | string |
| email    | string |
| password | string |


| Store    |        |
| -------- | ------ |
| user_id  | FK     |
| name     | string |
| note     | text   |
| tel      | string |
| address  | string |


| Product    |           |
| --------   | --------- |
| store_id   | FK        |
| title      | string    |
| list_price | decimal   |
| quantity   | integer   |
| shipping_fee | decimal |

| OrderItem  |         |
| ---------- | ------- |
| product_id | FK      |
| order_id   | FK      |
| sell_price | decimal |
| quantity   | integer |

| Order          |        |
| -------------- | ------ |
| recipient      | string |
| tell           | string |
| address        | string |
| note           | note   |
| status         | string |
| num            | string |
| serial_number  | string |
| shipping_fee   | decimal|

| Coupon_record  |         |
| -------------- | ------- |
| coupon_id      | FK      |
| order_id       | FK      |
| need_count     | boolean |
| best_discount  | decimal |

| Coupon                  |                         |
| ------------------------| ----------------------- |
| store_id                | FK                      |
| prodcut_id              | FK, optional: true      |
| name                    | string                  |
| condition_type          | integer                 |
| condition_value         | decimal                 |
| discount_type           | integer                 |
| discount_value          | decimal                 |
| total_redemption_type   | integer                 |
| total_redemption_value  | decimal                 |
| people_redemption_type  | integer                 |
| people_redemption_value | decimal                 |
| effect_start_date       | date                    |
| effect_end_date         | date                    |
| with_enable             | boolean, defautlt: true |
| month_reset             | boolean                 |

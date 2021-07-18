---
title: Phương thức thanh toán Softbank cài đặt bằng ngôn ngữ PHP
categories:
- Tutorial
- Payment
tags:
- php
- softbank
- au
- paypay
---

# Phương thức Softbank payment bằng PHP
Tôi sẽ bắt đầu với nội dung bài viết luôn, với lý do là có biết bao phương thức payment và nếu bạn làm việc ở thị trường Nhật thì softbank payment là một phương thức thanh toán khá thông dụng. 
## Liên kết:  
- Địa chỉ softbank:[ https://www.sbpayment.jp/](https://www.sbpayment.jp/)
- Địa chỉ cho lập trình viên: [https://developer.sbpayment.jp/](https://developer.sbpayment.jp/)
- Bài viết tham khảo: [https://kipalog.com/posts/Tich-hop-softbank-payment-cho-trang-web-cua-ban ](https://kipalog.com/posts/Tich-hop-softbank-payment-cho-trang-web-cua-ban )

## Softbank payment 
Softbank payment là một phương thức thanh toán khá thông dụng tại các website thương mại điện tử tại Nhật, nó đáp ứng một số lượng lớn các thẻ thanh toán nội địa cũng như master, visa, ngoài ra alipay v..v...
- Softbank payment cung cấp 2 cách để thanh toán(link type, API type):
	- Api tích hợp 
	- Liên kết tới trang trung gian của softbank payment. \\
 
Phương thức bảo mật: 3D secure (3Ds), giống như phương thức thanh toán xác thực 2 bước\\
Softbank payment cũng có dịch vụ khá giống với stripe:
- Online payment service
- Payment service for stores: pot, qr, mobile 
- Partner program 
\\
## Tích hợp softbank payment 
### Đăng ký tài khoản 
các bạn vào link sau đây để đăng ký tài khoản nhé:
https://developer.sbpayment.jp/user_regist/consent \\
Softbank cung cấp môi trường sanbox nếu bạn muốn test hoặc trải nghiệm. Trong bài viết này tôi muốn giới thiệu đến phương thức thanh toán sự dụng liên kết tới bên thứ ba 
### Cài đặt form 
Mẫu form tương ứng: gồm các thông số kèm order chi tiết. 
#### Thông tin form, order 
```
order.pay_method = "";
order.merchant_id = "30132";
order.service_id = "001";
```
#### Thông tin merchant 
```
credit：クレジットカード決済
credit3d：クレジットカード決済（本人認証サービス
（3D セキュア））
unionpay：銀聯ネット決済
webcvs：Web コンビニ決済
payeasy：Pay-easy 決済
banktransfer：総合振込決済
cyberedy：楽天 Edy 決済（楽天 Edy）
mobileedy：楽天 Edy 決済（モバイル楽天 Edy）
suica：モバイル Suica 決済
webmoney：WebMoney 決済
netcash：Net Cash 決済
bitcash：BitCash 決済
prepaid：JCB PREMO 決済
docomo：ドコモ払い
auone：au かんたん決済
softbank：S!まとめて支払い
yahoowallet：Yahoo!ウォレット決済
yahoowalletdg：Yahoo!ウォレット決済（デジコン
版）
rakuten：楽天ペイ（オンライン決済）
recruit：リクルートかんたん支払い
alipay：Alipay 国際決済
paypal：Paypal 決済
netmile：ネットマイル決済
mysoftbank：ソ フトバ ンク まとめて支払い（Ａ）
softbank2：ソフトバンクまとめて支払い（Ｂ）
saisonpoint：永久不滅ポイント
linepay：LINE Pay
tpoint：T ポイントプログラム（オンライン決済）
applepay：Apple Pay
nppostpay：NP 後払い
```
Mình chọn phương thức *paypay* , bạn có thể nhập chực tiếp paypay không cần nhập mã id của các phương thức.\\
Bạn vào trang paypay và đăng ký tài khoản developer tại đây [https://www.paypal.com](https://www.paypal.com) \\

Tôi có lấy mẫu từ trang developer:

```php 
function f_submit() {

    var order = new Order();
    order.pay_method            = "1234";
    order.merchant_id           = "30132";
    order.service_id            = "001";
    order.cust_code             = "Merchant_TestUser_999999";
    order.sps_cust_no           = "1234";
    order.sps_payment_no        = "1234";
    order.order_id              = "a1a1be0a082ac31eedbd126c8b0b0d5a";
    order.item_id               = "T_0003";
    order.pay_item_id           = "";
    order.item_name             = "テスト商品";
    order.tax                   = "";
    order.amount                = "1";
    order.pay_type              = "0";
    order.auto_charge_type      = "";
    order.service_type          = "0";
    order.div_settele           = "";
    order.last_charge_month     = "";
    order.camp_type             = "";
    order.tracking_id           = "";
    order.terminal_type         = "0";
    order.success_url           = "http://stbfep.sps-system.com/MerchantPaySuccess.jsp";
    order.cancel_url            = "http://stbfep.sps-system.com/MerchantPayCancel.jsp";
    order.error_url             = "http://stbfep.sps-system.com/MerchantPayError.jsp";
    order.pagecon_url           = "http://stbfep.sps-system.com/MerchantPayResultRecieveSuccess.jsp";
    order.free1                 = "";
    order.free2                 = "";
    order.free3                 = "";
    order.free_csv_input        =
        "LAST_NAME=鈴木,FIRST_NAME=太郎,LAST_NAME_KANA=スズキ,FIRST_NAME_KANA=タロウ,FIRST_ZIP=210,SECOND_ZIP=0001,ADD1=岐阜県,ADD2=あああ市あああ町,ADD3=,TEL=12345679801,MAIL=aaaa@bb.jp,ITEM_NAME=TEST ITEM";
    order.request_date          = "20210718190350";
    order.limit_second          = "";
    order.hashkey               = "c48e0e2c7d04f0954594f14c7801bd430ca6263e";

    var orderDetail = new OrderDetail();
    orderDetail.dtl_rowno       = "1";
    orderDetail.dtl_item_id     = "dtlItem_1";
    orderDetail.dtl_item_name   = "明細商品名1";
    orderDetail.dtl_item_count  = "1";
    orderDetail.dtl_tax         = "1";
    orderDetail.dtl_amount      = "1";
    orderDetail.dtl_free1       = "";
    orderDetail.dtl_free2       = "";
    orderDetail.dtl_free3       = "";
    order.orderDetail.push(orderDetail);

    // フリーCSV
    order.free_csv              = base64.encode(order.free_csv_input, 1);

    //チェックサム
    order.sps_hashcode          = Sha1.hash( order.toString() );

    feppost(order);
}

// オブジェクト定義[OrderDetail]
function OrderDetail()
{
    this.toString = function() {
        var result =
            this.dtl_rowno +
            this.dtl_item_id +
            this.dtl_item_name +
            this.dtl_item_count +
            this.dtl_tax +
            this.dtl_amount +
            this.dtl_free1 +
            this.dtl_free2 +
            this.dtl_free3;
        return result;
    }
}

// オブジェクト定義[Order]
function Order()
{
    this.orderDetail = new Array();
    this.toString = function() {

        var resultOrderDetail = "";
        for (i = 0; i < this.orderDetail.length; i++) {
            resultOrderDetail = resultOrderDetail + this.orderDetail[i].toString();
        }

        var result =
            this.pay_method +
            this.merchant_id +
            this.service_id +
            this.cust_code +
            this.sps_cust_no +
            this.sps_payment_no +
            this.order_id +
            this.item_id +
            this.pay_item_id +
            this.item_name +
            this.tax +
            this.amount +
            this.pay_type +
            this.auto_charge_type +
            this.service_type +
            this.div_settele +
            this.last_charge_month +
            this.camp_type +
            this.tracking_id +
            this.terminal_type +
            this.success_url +
            this.cancel_url +
            this.error_url +
            this.pagecon_url +
            this.free1 +
            this.free2 +
            this.free3 +
            this.free_csv +
            resultOrderDetail +
            this.request_date +
            this.limit_second +
            this.hashkey;
        return result;
    };
}

// 日時の取得
function getYYYYMMDDHHMMSS(){
    var now = new Date();
    return now.getFullYear() + zeroPadding(now.getMonth() + 1) + zeroPadding(now.getDate()) +
           zeroPadding(now.getHours()) + zeroPadding(now.getMinutes()) + zeroPadding(now.getSeconds());
}

function zeroPadding(num) {
    if (num < 10) { num = "0" + num; }
	return num + "";
}

function feppost(order) {

    var connectUrl = "https://stbfep.sps-system.com/f01/FepBuyInfoReceive.do";
    var form =
        $('<form></form>',{action:connectUrl,target:'receiver',method:'POST'}).hide();

    var body = $('body');
    body.append(form);
    form.append($('<input>',{type:'hidden',name:'pay_method'        ,value:order.pay_method                  }));
    form.append($('<input>',{type:'hidden',name:'merchant_id'       ,value:order.merchant_id                 }));
    form.append($('<input>',{type:'hidden',name:'service_id'        ,value:order.service_id                  }));
    form.append($('<input>',{type:'hidden',name:'cust_code'         ,value:order.cust_code                   }));
    form.append($('<input>',{type:'hidden',name:'sps_cust_no'       ,value:order.sps_cust_no                 }));
    form.append($('<input>',{type:'hidden',name:'sps_payment_no'    ,value:order.sps_payment_no              }));
    form.append($('<input>',{type:'hidden',name:'order_id'          ,value:order.order_id                    }));
    form.append($('<input>',{type:'hidden',name:'item_id'           ,value:order.item_id                     }));
    form.append($('<input>',{type:'hidden',name:'pay_item_id'       ,value:order.pay_item_id                 }));
    form.append($('<input>',{type:'hidden',name:'item_name'         ,value:order.item_name                   }));
    form.append($('<input>',{type:'hidden',name:'tax'               ,value:order.tax                         }));
    form.append($('<input>',{type:'hidden',name:'amount'            ,value:order.amount                      }));
    form.append($('<input>',{type:'hidden',name:'pay_type'          ,value:order.pay_type                    }));
    form.append($('<input>',{type:'hidden',name:'auto_charge_type'  ,value:order.auto_charge_type            }));
    form.append($('<input>',{type:'hidden',name:'service_type'      ,value:order.service_type                }));
    form.append($('<input>',{type:'hidden',name:'div_settele'       ,value:order.div_settele                 }));
    form.append($('<input>',{type:'hidden',name:'last_charge_month' ,value:order.last_charge_month           }));
    form.append($('<input>',{type:'hidden',name:'camp_type'         ,value:order.camp_type                   }));
    form.append($('<input>',{type:'hidden',name:'tracking_id'       ,value:order.tracking_id                 }));
    form.append($('<input>',{type:'hidden',name:'terminal_type'     ,value:order.terminal_type               }));
    form.append($('<input>',{type:'hidden',name:'success_url'       ,value:order.success_url                 }));
    form.append($('<input>',{type:'hidden',name:'cancel_url'        ,value:order.cancel_url                  }));
    form.append($('<input>',{type:'hidden',name:'error_url'         ,value:order.error_url                   }));
    form.append($('<input>',{type:'hidden',name:'pagecon_url'       ,value:order.pagecon_url                 }));
    form.append($('<input>',{type:'hidden',name:'free1'             ,value:order.free1                       }));
    form.append($('<input>',{type:'hidden',name:'free2'             ,value:order.free2                       }));
    form.append($('<input>',{type:'hidden',name:'free3'             ,value:order.free3                       }));
    form.append($('<input>',{type:'hidden',name:'free_csv'          ,value:order.free_csv                    }));
    form.append($('<input>',{type:'hidden',name:'request_date'      ,value:order.request_date                }));
    form.append($('<input>',{type:'hidden',name:'limit_second'      ,value:order.limit_second                }));
    form.append($('<input>',{type:'hidden',name:'hashkey'           ,value:order.hashkey                     }));
    form.append($('<input>',{type:'hidden',name:'sps_hashcode'      ,value:order.sps_hashcode                }));

    for (i = 0; i < order.orderDetail.length; i++) {
        form.append($('<input>',{type:'hidden',name:'dtl_rowno'         ,value:order.orderDetail[i].dtl_rowno             }));
        form.append($('<input>',{type:'hidden',name:'dtl_item_id'       ,value:order.orderDetail[i].dtl_item_id           }));
        form.append($('<input>',{type:'hidden',name:'dtl_item_name'     ,value:order.orderDetail[i].dtl_item_name         }));
        form.append($('<input>',{type:'hidden',name:'dtl_item_count'    ,value:order.orderDetail[i].dtl_item_count        }));
        form.append($('<input>',{type:'hidden',name:'dtl_tax'           ,value:order.orderDetail[i].dtl_tax               }));
        form.append($('<input>',{type:'hidden',name:'dtl_amount'        ,value:order.orderDetail[i].dtl_amount            }));
        form.append($('<input>',{type:'hidden',name:'dtl_free1'         ,value:order.orderDetail[i].dtl_free1             }));
        form.append($('<input>',{type:'hidden',name:'dtl_free2'         ,value:order.orderDetail[i].dtl_free2             }));
        form.append($('<input>',{type:'hidden',name:'dtl_free3'         ,value:order.orderDetail[i].dtl_free3             }));
    }

    form.submit();
}
```
bước 3: Ajax call back 
```js
 $.ajax({
         method: 'POST',
         data: {
             free_csv: order.free_csv_input
         },
         url: urlGetFreeCsv
     }).done((encrypt) => {
         //チェックサム
         order.free_csv = encrypt;
         $.ajax({
             method: 'POST',
             data: {
                 text: order.toString()
             },
             url: urlgenHashKey
         }).done((sps_hashcode) => {
             order.sps_hashcode = sps_hashcode;
             feppost(order);
         });
     });
```
### 3D-Secure callback 
Vì sử dụng 3Ds nên phía ngân hàng bắt buộc mình phải mã hoá một số nội dung liên quan đên thông tin tài khoản ( one time token ) bắt mình phải mã hoá dữ liệu theo thuật toán 3DES như sau:
bước 1: Tạo spsHashcode
```php
    public function generateSpsHashcode()
    {
        $data = $this->request->data;
        if (isset($data['text']) && $data['text']) {
            $text = $data['text'];
            echo $this->generateSpsHashcode($text);
        }
        die;
    }

private function generateSpsHashcode($string)
    {
        $hashKey = Configure::read('Purchase.hashKey');
        return sha1($string.$hashKey);
    }
```
bước 2: tạo free csv

```php
public function generateFreeCsv()
    {
        $data = $this->request->data;
        if (isset($data['free_csv']) && $data['free_csv']) {
            $text = $data['free_csv'];
            echo $this->encrypt3DES($text);die;
        }
        die;
    }

private function encrypt3DES($text)
    {
        $text = $this->padding3DES($text);
        $cipher = 'DES-EDE3-CBC';
        $secretKey = Configure::read('Purchase.secretKey');
        $iv = Configure::read('Purchase.iv');
        if (in_array($cipher, openssl_get_cipher_methods()))
        {
            $ciphertext = openssl_encrypt($text, $cipher, $secretKey, $options=0, $iv);
        }
        return $ciphertext;
    }

private function padding3DES($text)
    {
        $mod = strlen($text) % 8;
        if ($mod === 0) {
            return $text;
        }
        $padding = '';
        for ($i = 0; $i < 8 - $mod; $i++) {
            $padding .= ' ';
        }
        return $text.$padding;
    }
```

### Callback URL code 
* Success
* Error
* Cancel
* Pagecon callback: 
	Đây là url quan trọng để khi bạn xác thực thành công thông tin thẻ, ngân hàng sẽ request đến url này của bạn báo rằng KH có thể thanh toán được, ở đây mình phải tiến hành xử lí cho tài khoản đã thanh toán tuỳ vào nghiệp vụ của trang web, sau đó trả về ***OK*** nếu thành công hoặc ***NG*** nếu thất bại.
	
## Kết Luận 
Đối với phương thức thanh toán bằng softbank, tôi cũng chỉ khái quát được nội dung và cách kết nối. Phần xử lý callback có lẽ mình sẽ viết kỹ hơn vào bài sau nếu có thời gian.
## Chú thích
- 3D-secure: is a protocol designed to be an additional security layer for online credit and debit card transactions. The name refers to the "three domains" which interact using the protocol: the merchant/acquirer domain, the issuer domain, and the interoperability domain.

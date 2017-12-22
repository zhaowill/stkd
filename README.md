# 股票信息查询命令——stkd命令

### 这个命令的作用是根据输入的股票代码查询股票的详细信息。

![示例图片](https://github.com/czxa/stkd/raw/master/example.png)

### 安装：

#### 首先你需要安装github命令，这个命令是用来安装github上的命令的：
```stata
net install github, from("https://haghish.github.io/github/")
```

#### 然后就可以安装这个命令了：
```stata
github install czxa/stkd, replace
```
<!--more-->
#### 或者下载安装：
* 另外你也可以从这里把ado文件和sthlp文件下载下来，然后放在你的Stata系统文件夹里，查看系统文件夹的路径可以运行下面的命令：

```stata
sysdir
```
* 放在那个文件夹里都可以，推荐放在plus文件夹里。

#### 用法：
##### 基本语法：

**stkd** codelist, **[path**(*string*) **store** **iterm**(*string*) **fmt**(*string*) **cite]**

**codelist**: 是一列你想要查询详细信息的股票代码列表。如果不足六位，该命令会自动在代码前面加0补齐至六位。

##### 选项

**path**(*string*): 指定保存文件的路径，默认为当前工作目录。

**store**: 选择是否要储存股票信息文件，默认不保存。

**fmt**(*string*): 选择要储存股票信息文件的格式，默认为txt格式，指定该选项时会自动保存。

**cite**: 如果你需要引用该命令，加上该选项可以显示引用格式。

**iterm**(*string*): 选择要直接显示出来的股票信息，默认会显示股票的名称。有一下选择，很容易发现，这些都是对应股票信息的拼音缩写：

* 可选选选项主要分为基础信息、工商信息、经营范围、证券信息、联系方式以及公司简介六类，使用这六个词的拼音缩写就会显示该类别的所有信息，另外可以使用_all选项显示所有的信息。

> _all: 全部信息

> jcxx: 【基础信息】

>> gpdm: 股票代码

>> gsqc: 公司全称

>> gsywmc: 公司英文名称

>> cym: 曾用名

>> clrq: 成立日期

>> sshy: 所属行业

>> ssgn: 所属概念

>> ssdy: 所属地域

>> fddbr: 法定代表人

>> dlds: 独立董事

>> zxfwjg: 咨询服务机构

>> kjssws: 会计师事务所

>> zqswdb: 证券事务代表

> jyfw: 【经营范围】

>> jyfw: 经营范围

> zqxx: 【证券信息】

>> ssrq: 上市日期

>> ssjys: 上市交易所

>> zqlx: 证券类型

>> ltgb: 流通股本

>> zgb: 总股本

>> zcxs: 主承销商

>> fxj: 发行价

>> sssrkpj: 上市首日开盘价

>> sssrzdf: 上市首日涨跌幅

>> sssrhsl: 上市首日换手率

>> tbclhts: 特别处理和退市

>> fxsyl: 发行市盈率

>> zxsyl: 最新市盈率

> lxfs: 【联系方式】

>> lxdhdm: 联系电话（董秘）

>> gscz: 公司传真

>> dzyx: 电子邮箱

>> gswz: 公司网站

>> lxr: 联系人

>> yzbm: 公司邮编

> gsjj: 【公司简介】

>> gsjj: 公司简介

##### 返回值

在运行完stkd后运行下面的命令可以查看返回值。

```stata
return list
```

> 上面所列的每一条信息都储存在返回值里。可以使用r()进行调用。


##### 示例

```
stkd 1
stkd 2, i(jyfw)
stkd 4, s
stkd 5, path(~/Desktop) s
stkd 6, fmt(dta)
stkd 7, c
```

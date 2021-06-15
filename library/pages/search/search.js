// pages/search/search.js
import {
  request
} from "../../request/index";
import regeneratorRuntime from '../../lib/runtime/runtime';
Page({
  data: {
    books: [],
    baseServer:'http://localhost:8080',
    isFocus: false,
    isNothing: false,
    msg: ""
  },
  TimeId: -1,

  //输入框的值改变 就会触发的事件
  handleInput(e) {
    // 获取输入框的值
    const {
      value
    } = e.detail;
    if (!value.trim()) {
      this.setData({
        books: [],
        msg: "",
        isFocus: false
      });
      //值不合法
      clearTimeout(this.TimeId);
      return;
    }
    //发送请求获取数据
    this.setData({
      isFocus: true
    });
    clearTimeout(this.TimeId);
    this.TimeId = setTimeout(() => {
      this.bookSearch(value);
    }, 1000);
  },
  //发送请求获取搜索结果数据
  async bookSearch(query) {
    const res = await request({
      url: "/book/bookSearch",
      data: {
        'content': query,
      },
      header: {
        'content-type': 'application/json'
      },
    });
    if(res.extend.pageInfo.list.length==0){
      this.setData({
        msg: "很抱歉没搜索到！！！"
      });
      return;
    }
    console.log(res.extend.pageInfo.list);
    this.setData({
      books: res.extend.pageInfo.list,
      msg: "为您搜索到以下图书"
    });
    if(res.extend.pageInfo.list.lenth==0){
      this.setData({
        isNothing:true,
      });
    }
  },
  handleCancle() {
    this.setData({
      inputValue: '',
      isFocus: false,
      msg: "",
      books: []
    });
  }
})
// pages/myBorrow/myBorrow.js
const app = getApp()
var ss= require("../../utils/util.js");
import {
  request
} from "../../request/index";
import regeneratorRuntime from '../../lib/runtime/runtime';
Page({
  data: {
    uno:'',
    baseServer:'http://localhost:8080',
    borrows:[]
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.setData({
      uno: app.globalData.userInfo.uno,
    });
    let uno = this.data.uno;
    this.getMyBorrows(uno);
  },
  async getMyBorrows(uno){
    const res = await request({
      url: "/borrow/getMyBorrow/"+uno,
      header: {
        'content-type': 'application/json'
      },
    });
    console.log(res);
    if(res.extend.myBorrow.length>0){
      for(var i =0; i< res.extend.myBorrow.length; i++){
        var time =  res.extend.myBorrow[i]["btime"];
        res.extend.myBorrow[i]["btime"] = ss.tsFormatTime(time, 'Y-M-D h:m:s')
      }
    }
    this.setData({
      borrows:res.extend.myBorrow
    })
  },
})
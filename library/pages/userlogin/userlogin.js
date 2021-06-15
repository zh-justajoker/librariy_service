// pages/userlogin/userlogin.js
import {
  request
} from "../../request/index";
import regeneratorRuntime from '../../lib/runtime/runtime';
var app = getApp();
Page({
  data: {
    uno: '',
    upwd: '',
    uno: function (e) {
      var that = this;
      that.setData({
        uno: e.detail.value
      })
    },
    upwd: function (e) {
      var that = this;
      that.setData({
        upwd: e.detail.value
      })
    },
    showTopTips: false,
    errorMsg: ""
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function () {

  },
  formSubmit: function (e) {
    var uno = e.detail.value.uno;
    var upwd = e.detail.value.upwd;
    this.login(uno, upwd);
  },
  async login(uno, upwd) {
    const res = await request({
      url: "/user/login",
      data: {
        'uno': uno,
        'upwd': upwd,
      },
      method: "POST",
      header: {
        'content-type': 'application/x-www-form-urlencoded'
      },
    });
    console.log(res);
    if (res.code == 200) {
      wx.showToast({
        title: '账号或密码错误',
        icon: 'loading',
        duration: 2000
      })
      this.setData({
        uno:'',
        upwd:''
      });
    } else {
      wx.showToast({
        title: '登录成功',
        icon: 'success',
        duration: 1000
      })
      app.globalData.userInfo = res.extend.user;
      wx.switchTab({
        url: '/pages/index/index',
      })
    }
  }


})
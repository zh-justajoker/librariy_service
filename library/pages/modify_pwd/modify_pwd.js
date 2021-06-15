// pages/modify_pwd/modify_pwd.js
const app = getApp()
import {
  request
} from "../../request/index";
import regeneratorRuntime from '../../lib/runtime/runtime';
Page({

  /**
   * 页面的初始数据
   */
  data: {
    oldPwd:'',
    newPwd:'',
    confNewPwd:'',
    oldPwd: function (e) {
      var that = this;
      that.setData({
        oldPwd: e.detail.value
      })
    },
    newPwd: function (e) {
      var that = this;
      that.setData({
        newPwd: e.detail.value
      })
    },
    confNewPwd: function (e) {
      var that = this;
      that.setData({
        confNewPwd: e.detail.value
      })
    },
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
  },

  formSubmit: function (e) {
    let uno = app.globalData.userInfo.uno;
    let upwd = app.globalData.userInfo.upwd;
    var oldPwd = e.detail.value.oldPwd;
    var newPwd = e.detail.value.newPwd;
    var confNewPwd = e.detail.value.confNewPwd;
    if(upwd == oldPwd){
      if(newPwd == confNewPwd){
        this.modifyPwd(uno,newPwd)
      }
      else{
        wx.showToast({
          title: '两次密码不一致',
          icon: 'loading',
          duration: 2000
        })
      }

    }
    else{
      wx.showToast({
        title: '旧密码密码错误',
        icon: 'loading',
        duration: 2000
      })
    }
    
  },
  async modifyPwd(uno, upwd) {
    const res = await request({
      url: "/user/modifyPwd",
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
        title: '修改密码失败',
        icon: 'loading',
        duration: 2000
      })
      this.setData({
        uno:'',
        upwd:''
      });
    } else {
      wx.showToast({
        title: '修改成功，请重新登录',
        icon: 'success',
        duration: 1000
      })
      wx.reLaunch({
        url: '/pages/userlogin/userlogin',
        success:()=>{
          app.globalData.userInfo = [];
        }
      })
    }
  },
})
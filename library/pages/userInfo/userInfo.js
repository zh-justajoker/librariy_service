// pages/userInfo/userInfo.js
var app = getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    uno:'',
    uname:'',
    sex:'',
    age:'',
    dname:''
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    let userInfo = app.globalData.userInfo;
    if(userInfo != null){
      this.setData({
        uno: userInfo.uno,
        uname: userInfo.uname,
        sex: userInfo.sex==0 ?'男':'女',
        age: userInfo.age,
        dname: userInfo.dname
      });
    }
  },



  
})
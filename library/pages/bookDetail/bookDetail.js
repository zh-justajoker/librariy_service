// pages/bookDetail/bookDetail.js
const app = getApp()
import {
  request
} from "../../request/index";
import regeneratorRuntime from '../../lib/runtime/runtime';

Page({
  data: {
    userInfo:{},
    bookInfo:[],
    baseServer:'http://localhost:8080',
    bId:'',
    isNeedReco:true,
  },
 
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    const {btxm} = options;
    this.setData({
      userInfo: app.globalData.userInfo,
      bId:btxm
    });
    let uno = app.globalData.userInfo.uno;
    this.getBook(btxm);
    this.isNeedReco(uno,btxm);
  },
  async getBook(btxm){
    const res = await request({
      url: "/book/getbyId/"+btxm,
      header: {
        'content-type': 'application/json'
      },
    });
    console.log(res);
    this.setData({
      bookInfo:res.extend.bookbyid
    })
  },
  async isNeedReco(uno,btxm){
    const res = await request({
      url: "/userReco/isNeedReco",
      data:{
        'uno':uno,
        'btxm':btxm
      },
      header: {
        'content-type': 'application/json'
      },
    });

    this.setData({
        isNeedReco:res.extend.isNeed
    })
    
  },
  handChangeState(){
    this.insertBorrow();
  },
  async insertBorrow(){
    let userInfo = this.data.userInfo;
    let bookInfo = this.data.bookInfo;
    var timestamp = Date.parse(new Date());  
    timestamp = timestamp;  
    let addBw = {
      "uno":userInfo.uno,
      "uname":userInfo.uname,
      "btxm":bookInfo.btxm,
      "bname":bookInfo.bname,
      "author":bookInfo.author,
      "bookImg":bookInfo.bookImg,
      "btime":timestamp,
      "state":0
    }
    const res = await request({
      url: "/borrow/addBorrow",
      data:addBw,
      method:"POST",
      dataType: 'json',
      header: {
        'content-type': 'application/x-www-form-urlencoded'
      },
      
    });
    console.log(res);
    if (res.code == 200) {
      wx.showToast({
        title: '您已经借了15本书了',
        icon: 'loading',
        duration: 2000
      })
    }
    else{
      wx.showToast({
        title: '预约成功',
        icon: 'success',
        duration: 1000
      })
      this.upBookState();
    }
  },
  async upBookState(){
    const res = await request({
      url: "/book/upBookState",
      data:{
        'btxm':this.data.bId,
        'state':2
      },
      method:"POST",
      header: {
        'content-type': 'application/x-www-form-urlencoded'
      },
    });
    if(res.code==100){
      this.getBook(this.data.bId);
    }
  },
  //点击推荐
  handleRecommend(){
    this.addUserReco();
    let uno = this.data.userInfo.uno;
    let btxm = this.data.bId;
    wx.showToast({
      title: '推荐成功',
      icon: 'success',
    })
    this.isNeedReco(uno,btxm);
    wx.hideToast();
  },
  async addUserReco(){
    let userInfo = this.data.userInfo;
    let bookInfo = this.data.bookInfo;
    let addReco = {
      "uno":userInfo.uno,
      "btxm":bookInfo.btxm,
      "bname":bookInfo.bname,
      "author":bookInfo.author,
      "bookImg":bookInfo.bookImg,
      "isbn":bookInfo.isbn
    }
    const res = await request({
      url: "/userReco/addUserReco",
      data:addReco,
      method:"POST",
      dataType: 'json',
      header: {
        'content-type': 'application/x-www-form-urlencoded'
      },
    });
    console.log(res);
  },
  //提示已推荐
  handleUnRecommend(){
    wx.showToast({
      title: '不可重复推荐',
      icon: 'loading',
      duration: 1000
    })
  },
  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {

  },
})
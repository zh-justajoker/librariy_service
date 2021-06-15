// pages/borrow_his/borrow_his.js
const app = getApp()
var ss= require("../../utils/util.js");
import {
  request
} from "../../request/index";
import regeneratorRuntime from '../../lib/runtime/runtime';
Page({
  /**
   * 页面的初始数据
   */
  data: {
    uno:'',
    baseServer:'http://localhost:8080',
    tabs:[
      {
        id:0,
        value:'已预约',
        isActive:true
      },
      {
        id:1,
        value:'借阅中',
        isActive:false
      },
      {
        id:2,
        value:'已归还',
        isActive:false
      }
    ],
    borrows0:[],
    borrows1:[],
    borrows2:[]
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.setData({
      uno: app.globalData.userInfo.uno,
    });
    let uno = this.data.uno;
    this.getBorrowHis(uno)
  },
  async getBorrowHis(uno){
    const res = await request({
      url: "/borrow/getBorrowHis/"+uno,
      header: {
        'content-type': 'application/json'
      },
    });
    console.log(res);
    var borrows0 = [];
    var borrows1 = [];
    var borrows2 = [];
    if(res.extend.borrowHis.length>0){
      for(var i =0; i< res.extend.borrowHis.length; i++){
        var time =  res.extend.borrowHis[i]["btime"];
        var state = res.extend.borrowHis[i]["state"];
        res.extend.borrowHis[i]["btime"] = ss.tsFormatTime(time, 'Y-M-D h:m:s')
        if(state == 0){
          borrows0.push(res.extend.borrowHis[i]);
        }
        else if(state == 1){
          borrows1.push(res.extend.borrowHis[i]);
        }
        else if(state == 2){
          borrows2.push(res.extend.borrowHis[i]);
        }
      }
    }
    this.setData({
      borrows0: borrows0,
      borrows1: borrows1,
      borrows2: borrows2,
    })
  },
  //标题点击事件
  handleTabsItemChange(e){
    const {index} = e.detail;
    let {tabs} = this.data;
    tabs.forEach((v,i)=>i===index?v.isActive=true:v.isActive=false);
    this.setData({
      tabs
    })
  }
})
// pages/recommend/recommend.js
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
    data: {
      uno: '',
      management_book: false,
      baseServer:'http://localhost:8080',
      middlearr: [],
      select_all: false,
      myReco: [{
        recoBooks: {},
        checked: false
      }]

    },
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.setData({
      uno: app.globalData.userInfo.uno
    });
    let uno = this.data.uno;
    this.getRecoBookList(uno);
  },

  async getRecoBookList(uno) {
    const res = await request({
      url: "/userReco/getMyRecoList/" + uno,
      header: {
        'content-type': 'application/json'
      },
    });
    console.log(res);
    let myRecos = res.extend.userRecomends;
    let myReco = [];
    for (let i = 0; i < myRecos.length; i++) {
      myReco.push({
        "recoBooks": myRecos[i],
        checked: false
      });
    }
    this.setData({
      myReco: myReco
    });
  },

  deleteitem() {
    let arr = this.data.myReco;
    let arr2 = [];
    let arr3 = []
    for (let i = 0; i < arr.length; i++) {
      if (arr[i].checked == false) {
        arr2.push(arr[i]);
      }
      else{
        arr3.push({
          'uno':arr[i].recoBooks.uno,
          'btxm':arr[i].recoBooks.btxm
        })
      }
    }
    this.deleteReco(arr3);
    this.setData({
      myReco: arr2,
      middlearr: []
    })
  },
  async deleteReco(delReco){
    console.log(delReco);
    
    const res = await request({
      url: "/userReco/deleteMyre",
      data:{
        'delMyReos':JSON.stringify(delReco),
      },
      method:"POST",
      dataType: 'json',
      header: {
        'content-type': 'application/x-www-form-urlencoded'
      },
    });
    console.log(res);
  },
  management() {
    this.setData({
      management_book: true,
    })
  },
  finish_management() {
    this.setData({
      management_book: false,
    })
  },
  select(e) {
    let arr2 = [];
    if (this.data.management_book==null || this.data.management_book == false) {
      let index = e.currentTarget.dataset.id;
      let arr = this.data.myReco;
      let btxm = arr[index].recoBooks.btxm;
      wx.navigateTo({
        url:'/pages/bookDetail/bookDetail?btxm='+btxm
      });
      //return ;
    } else {
      var arr = this.data.myReco;
      var index = e.currentTarget.dataset.id;
      arr[index].checked = !arr[index].checked;
      for (let i = 0; i < arr.length; i++) {
        if (arr[i].checked) {
          arr2.push(arr[i])
        }
      };
      this.setData({
        myReco: arr,
        middlearr: arr2
      })
    }
  },
  select_all() {
    this.setData({
      select_all: !this.data.select_all
    })
    if (this.data.select_all) {
      let arr = this.data.myReco;
      let arr2 = [];
      for (let i = 0; i < arr.length; i++) {
        if (arr[i].checked == true) {
          arr2.push(arr[i]);
        } else {
          arr[i].checked = true;
          arr2.push(arr[i]);
        }
      }
      this.setData({
        myReco: arr2,
        middlearr: arr2
      })
    }
  },
  select_none() {
    this.setData({
      select_all: !this.data.select_all
    })
    let arr = this.data.myReco;
    let arr2 = [];
    for (let i = 0; i < arr.length; i++) {
      arr[i].checked = false;
      arr2.push(arr[i]);
    }
    this.setData({
      myReco: arr2,
      middlearr: []
    })
  },
  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    let uno = this.data.uno;
    this.getRecoBookList(uno);
  },
})
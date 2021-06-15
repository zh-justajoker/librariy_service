// index.js
// 获取应用实例
const app = getApp()
var ss= require("../../utils/util.js");
import {
  request
} from "../../request/index";
import regeneratorRuntime from '../../lib/runtime/runtime';
Page({
  data: {
    imgsw: [],
    baseServer:'http://localhost:8080',
    notice:{},
    tabs:[
      {
        id:0,
        value:'系统推荐',
        isActive:true
      },
      {
        id:1,
        value:'读者推荐',
        isActive:false
      }
    ],
    sysBooks:[],
    readerBooks:[]
  },
  onLoad() {
    var deptId = app.globalData.userInfo.deptId;
    this.getSwiperList();
    this.getNewNotice();
    this.getSysBooksList(deptId);
    this.getReaderBooksList(deptId);
  },
  async getSwiperList(){
    const res = await request({
      url: "/swiper/getlist",
      header: {
        'content-type': 'application/json'
      },
    });
    console.log(res);
    this.setData({
      imgsw:res.extend.swiperInfo.list
    })
  },
  async getNewNotice(){
    const res = await request({
      url: "/notice/getNewNotice",
      header: {
        'content-type': 'application/json'
      },
    });
    
    var time =  res.extend.newNotice["ntime"];
    res.extend.newNotice["ntime"] = ss.tsFormatTime(time, 'Y-M-D h:m')
    console.log(res);
    this.setData({
      notice:res.extend.newNotice
    })
  },
  async getSysBooksList(deptId){
    const res = await request({
      url: "/sysReco/getsysRecolist/"+deptId,
      header: {
        'content-type': 'application/json'
      },
    });
    console.log(res);
    this.setData({
      sysBooks:res.extend.sysreco
    })
  },
  
  async getReaderBooksList(deptId){
    const res = await request({
      url: "/userReco/getUserRecoList/"+deptId,
      header: {
        'content-type': 'application/json'
      },
    });
    console.log(res);
    this.setData({
      readerBooks:res.extend.userRecos
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
  },
   /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    this.onLoad();
  },
})

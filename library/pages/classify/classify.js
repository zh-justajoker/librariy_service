// pages/classify/classify.js
import {
  request
} from "../../request/index";
import regeneratorRuntime from '../../lib/runtime/runtime';
Page({
  /**
   * 页面的初始数据
   */
  data: {
    bookClassify: [],
    books: [],
    baseServer:'http://localhost:8080',
    curIndex: 0,
    scrollTop: 0
  },
  allbooks: [],

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    const allbooks = wx.getStorageSync('books');
    if (!allbooks) {
      this.getBooks();
    } else {
      if (Date.now() - allbooks.time > 1000 * 300) {
        this.getBooks();
      } else {
        this.allbooks = allbooks.data;
        let bookClassify = this.allbooks;
        let books = this.allbooks[0].books;
        this.setData({
          bookClassify,
          books
        })
      }
    }

  },
  async getBooks() {
    const res = await request({
      url: "/book/bookClassify",
      header: {
        'content-type': 'application/json'
      },
    })
    console.log(res);
    this.allbooks = res.extend.bookClassify;
    wx.setStorageSync('books', {
      time: Date.now(),
      data: this.allbooks
    });
    let bookClassify = this.allbooks;
    let books = this.allbooks[0].books;
    this.setData({
      bookClassify,
      books
    })
  },
  handleItemTap(e) {
    let index = e.target.dataset.index;
    let books = this.allbooks[index].books;
    this.setData({
      curIndex: index,
      books,
      scrollTop: 0
    })

  },
    /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    this.onLoad();
  },

  
})
export const request=(params)=>{
  // 定义公共的url
  wx.showLoading({
    title: '加载中',
    mask:true,
  })
  const baseUrl = "http://127.0.0.1:8080/ssm_library";
  return new Promise((resolve,reject)=>{
    wx.request({
      ...params,
      url:baseUrl+params.url,
      success:(result)=>{
        resolve(result.data);
      },
      fail:(err)=>{
        reject(err);
      },
      complete:()=>{
        wx.hideLoading();
      }
    })
  })
}
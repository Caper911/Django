/**

 @Name：layuiAdmin 主页控制台
 @Author：贤心
 @Site：http://www.layui.com/admin/
 @License：GPL-2
    
 */


layui.define(function(exports){
  var date = ['06:00','06:30','07:00','07:30','08:00','08:30','09:00','09:30','10:00','11:30','12:00','12:30','13:00','13:30','14:00','14:30','15:00','15:30','16:00','16:30','17:00','17:30','18:00','18:30','19:00','19:30','20:00','20:30','21:00','21:30','22:00','22:30','23:00','23:30'];
  var data1 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
  var data2 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
  var echartsApp = [];
  var addData = {
    adddata: function (dataone,datatwo) {

      date.shift();
      data1.shift();
      data2.shift();
      date.push('06:11');
      data1.push(dataone);
      data2.push(datatwo)


      echartsApp[0].setOption({
        xAxis: {
            data: date
        },
        series : [{
          name:'PV',
          data: data1
        },{
          name:'UV',
          data: data2
        }]
    });
    }
  };

  /*
    下面通过 layui.use 分段加载不同的模块，实现不同区域的同时渲染，从而保证视图的快速呈现
  */


    //数据概览
    layui.use(['carousel', 'echarts'], function(){
      var $ = layui.$
      ,carousel = layui.carousel
      ,echarts = layui.echarts;
      
  
  
      var options = [
        //今日流量趋势
        {
          title: {
            text: '今日流量趋势',
            x: 'center',
            textStyle: {
              fontSize: 14
            }
          },
          tooltip : {
            trigger: 'axis'
          },
          legend: {
            data:['','']
          },
          xAxis : [{
            type : 'category',
            boundaryGap : false,
            data: date
          }],
          yAxis : [{
            type : 'value',
            min:0,
            max:5000
          }],
          series : [{
            name:'PV',
            type:'line',
            smooth:true,
            itemStyle: {normal: {areaStyle: {type: 'default'}}},
            data: data1
          },{
            name:'UV',
            type:'line',
            smooth:true,
            itemStyle: {normal: {areaStyle: {type: 'default'}}},
            data: data2
          }]
        },
        
        //访客浏览器分布
        { 
          title : {
            text: '访客浏览器分布',
            x: 'center',
            textStyle: {
              fontSize: 14
            }
          },
          tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
          },
          legend: {
            orient : 'vertical',
            x : 'left',
            data:['Chrome','Firefox','IE 8.0','Safari','其它浏览器']
          },
          series : [{
            name:'访问来源',
            type:'pie',
            radius : '55%',
            center: ['50%', '50%'],
            data:[
              {value:9052, name:'Chrome'},
              {value:1610, name:'Firefox'},
              {value:3200, name:'IE 8.0'},
              {value:535, name:'Safari'},
              {value:1700, name:'其它浏览器'}
            ]
          }]
        },
        
        //新增的用户量
        {
          title: {
            text: '最近一周新增的用户量',
            x: 'center',
            textStyle: {
              fontSize: 14
            }
          },
          tooltip : { //提示框
            trigger: 'axis',
            formatter: "{b}<br>新增用户：{c}"
          },
          xAxis : [{ //X轴
            type : 'category',
            data : ['11-07', '11-08', '11-09', '11-10', '11-11', '11-12', '11-13']
          }],
          yAxis : [{  //Y轴
            type : 'value'
          }],
          series : [{ //内容
            type: 'line',
            data:[200, 300, 400, 610, 150, 270, 380],
          }]
        }
      ]
      ,elemDataView = $('#LAY-index-dataview').children('div')
      ,renderDataView = function(index){
        echartsApp[index] = echarts.init(elemDataView[index], layui.echartsTheme);
        
        echartsApp[index].setOption(options[index]);
  
        window.onresize = echartsApp[index].resize;
      };
      
  
      
      //没找到DOM，终止执行
      if(!elemDataView[0]) return;
      
      
      
      renderDataView(0);
      
      //监听数据概览轮播
      var carouselIndex = 0;
      carousel.on('change(LAY-index-dataview)', function(obj){
        renderDataView(carouselIndex = obj.index);
      });
      
      //监听侧边伸缩
      layui.admin.on('side', function(){
        setTimeout(function(){
          renderDataView(carouselIndex);
        }, 300);
      });
      
      //监听路由
      layui.admin.on('hash(tab)', function(){
        layui.router().path.join('') || renderDataView(carouselIndex);
      });
    });
  
  exports('echartdata', addData)
});
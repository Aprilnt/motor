$(function(){

	indexFun.init();



	$(".productsbox .top .l").slide({mainCell:".bd ul",autoPlay:true,effect:'fold'});



    $('.productsbox .bot div').hover(function(){

        $(this).addClass('on');

    },function(){

        $(this).removeClass('on');

    });





	//



	$(".sale-noticetab h3 a").click(function(){

		

        var _this = $(this)

        $("div.sale-noticecon").children(":eq("+_this.index()+")").show().siblings().hide();

        _this.addClass("active").siblings().removeClass("active");       

    });



    //

	jQuery(".aboutus-zrslide").slide({mainCell:".bd ul",autoPlay:true});



    //



	$(".yaindex-youshitab a").click(function(){

		

        var _this = $(this)

        $("div.tabconWrap").children(":eq("+_this.index()+")").show().siblings().hide();

        _this.addClass("active").siblings().removeClass("active");       

    });



	//

    $("a.event-btn").click(function(event) {

		$(this).stop().toggleClass('close-more');

		$(this).prev().stop().toggle();

	});

  //

    

   



	//弹窗



    $('.closeLogin').click(function(){

        $('#shade').hide();

        $('.pop').hide();

    });



    $('.add-servicecon li a').click(function(){

        var id = $(this).attr("id");

        $('#dest_popimg').attr("src", $('#popimg_' + id).val());

        $('#dest_fwjs').html($('#fwjs_' + id).val());

        $('#dest_fwtx').html($('#fwtx_' + id).val());

        $('#shade').fadeIn();

        $('.pop').show();

    });



  //弹窗



    $('.closebtn').click(function(){

        $('#shade2').hide();

        $('.index-pop').hide();

    });



    $('.phonebtn').click(function(){

        $('#shade2').fadeIn();

        $('.index-pop').show();

    });



    //点击其他地方弹窗消失

    $(document).click(function(event) {

       $('#shade').hide();

       $('.pop').hide();

    });



     $(document).click(function(event) {

       $('#shade2').hide();

       $('.index-pop').hide();

    });



    $(".pop,.add-servicecon li a,.phonebtn,.index-pop").click(function(event){

        if(event.stopPropagation)

        // this code is for Mozilla and Opera 

        event.stopPropagation();

        else if(window.event)

        // this code is for IE

        window.event.cancelBubble = true;       

    });



    //图片滚动

    jQuery(".yaindex-surright").slide({titCell:".hd ul",mainCell:".bd ul",autoPage:true,effect:"top",autoPlay:true,vis:3,trigger:"click"});	

    $(".surright-con ul li").click(function(){

		

        var _this = $(this)

        $(".yaindex-surleft ul").children(":eq("+_this.index()+")").show().siblings().hide();    

    });		



    daFun();





    $('.y-distri .y-searchcon .link li').click(function(){

      $(this).find('div').toggle();

      $(this).siblings().find('div').hide();

    });



 

     //省市区选择

    $('.citybox .choosecity').click(function(e){
        e.preventDefault();
        e.stopPropagation();

        callback_choosecity();

        $('.citybox .cityhide_1').hide();

        /*2015.7.30 afternoon change*/
        $(this).next('.cityhide').toggle();
        //$(this).parents('.xu-input.citybox').toggleClass("zindex");

    });

    $('.cityhide .menu1 li').click(function(e){
        e.preventDefault();
        e.stopPropagation();

          var _this =$(this);

          $('.cityhide .conten1').children(":eq("+_this.index()+")").show().siblings().hide();

          _this.addClass('on').siblings().removeClass('on');

    });



    $('.conten1 .city').each(function(){

      $(this).find('li').click(function(e){
        e.preventDefault();
        e.stopPropagation();

        var _this =$(this);

        $(this).parent('ul').next().children(":eq("+_this.index()+")").show().siblings().hide();

        _this.addClass('on').siblings().removeClass('on');

      });


    });


    $('.citybox .choosecity_1').click(function(e){
        e.preventDefault();
        e.stopPropagation();

        callback_choosecity1();

        $('.citybox .cityhide').hide();
        /*2015.7.30 afternoon change*/
        $(this).next('.cityhide_1').toggle();
        //$(this).parents('.xu-input.citybox').toggleClass("zindex");
    })

    $('.cityhide_1 .menu1_1 li').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        var _this =$(this);

        $('.cityhide_1 .conten1_1').children(":eq("+_this.index()+")").show().siblings().hide();

        _this.addClass('on').siblings().removeClass('on');

    });

    $('.conten1_1 .city_1').each(function(){

        $(this).find('li').click(function(e){
            e.preventDefault();
            e.stopPropagation();
            var _this =$(this);

            $(this).parent('ul').next().children(":eq("+_this.index()+")").show().siblings().hide();

            _this.addClass('on').siblings().removeClass('on');

        });

    });

    $(document).click(function(){
        $('.citybox .cityhide,.citybox .cityhide_1').hide();
    })




});



function reset_hotcity() {

     $('#hotcity').children('a').off('click').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        $('.cityhide .menu2 li:eq(0)').removeClass('on').next().next().next().addClass('on').siblings().removeClass('on');

        $('.cityhide .menu2 li:eq(3)').show();

        $(this).parent('div').hide().next().next().next().show().siblings().hide();

        var prov = $(this).attr("prov");
        callback_city(prov, $(this).text());

    });

}


function reset_province() {

    $('#province').children('a').off('click').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        $('.cityhide .menu2 li:eq(1)').removeClass('on').next().addClass('on').siblings().removeClass('on');

        $('.cityhide .menu2 li:eq(2)').show();

        $(this).parent('div').hide().next().show().siblings().hide();
       callback_province($(this).text());
    });

}

function reset_city() {

    $('#city').children('a').off('click').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        $('.cityhide .menu2 li:eq(2)').removeClass('on').next().addClass('on').siblings().removeClass('on');

        $('.cityhide .menu2 li:eq(3)').show();

        $(this).parent('div').hide().next().show().siblings().hide();

        callback_city(null, $(this).text());

    });

}



function reset_county() {

    $('#county').children('a').off('click').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        $('.citybox .cityhide').hide();

        callback_county($(this).text());

        $(this).parents('.xu-input.citybox').removeClass("zindex");

    });
}


// city 1
function reset_hotcity1() {

    $('#hotcity_1').children('a').off('click').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        $('.cityhide_1 .menu2_1 li:eq(0)').next().next().next().addClass('on').siblings().removeClass('on');

        $('.cityhide_1 .menu2_1 li:eq(3)').show();

        $(this).parent('div').hide().next().next().next().show().siblings().hide();

        var prov = $(this).attr("prov");
        callback_city1(prov, $(this).text());

    });

}



function reset_province1() {

    $('#province_1').children('a').off('click').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        $('.cityhide_1 .menu2_1 li:eq(1)').removeClass('on').next().addClass('on').siblings().removeClass('on');

        $('.cityhide_1 .menu2_1 li:eq(2)').show();

        $(this).parent('div').hide().next().show().siblings().hide();

        callback_province1($(this).text());

    });

}



function reset_city1() {

    $('#city_1').children('a').off('click').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        $('.cityhide_1 .menu2_1 li:eq(2)').removeClass('on').next().addClass('on').siblings().removeClass('on');

        $('.cityhide_1 .menu2_1 li:eq(3)').show();
        $(this).parent('div').hide().next().show().siblings().hide();

        callback_city1(null, $(this).text());

    });


}


function reset_county1() {

    $('#county_1').children('a').off('click').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        $('.citybox .cityhide_1').hide();

        callback_county1($(this).text());

    });

}



function daFun(){

	/*大事记*/

    var left = 0;

    var  n = 0;

    /* var width = document.documentElement.clientWidth; */

    var width = 978;

    var $width = $(".time-line").width();

    var Swidth = $(".time-line").find("ul").width();

    var num = Math.ceil(Swidth/width);

    var action = false;



   $(".event-next").click(function(event) {

       event.preventDefault();



       Swidth = $(".time-line").find("ul").width();

       num = Math.ceil(Swidth/width)



       if (!action) {

            action = true;

            //left -= width;

            n++;

            

            setTimeout(function() { action = false; }, 1000);

         	

            if(n >= num){

                n = num-1;

                return false;

            }

            $(".time-line > ul").stop().animate({"left":-n*width},1000);



            

        }

   });

   $(".event-prev").click(function(event) {

       event.preventDefault();



       Swidth = $(".time-line").find("ul").width();

       num = Math.ceil(Swidth/width)

       

       if (!action) {

            action = true;

          // left += width;

            n--;

            setTimeout(function() { action = false; }, 1000);

            if(n < 0 ){

            	n = 0;

            	return false;

            }

            $(".time-line > ul").stop().animate({"left":-n*width},1000);

        }

   });

   $(".time-line li").hover(function() {

   		$(this).addClass('on');

   }, function() {

   		$(this).removeClass('on')

   });

}

/*
 
 * 
 *      2015.7.10
 * 		zhaoshuan
 * 
 * 
 * */

var indexFun ={

	nav:function(){

		var nav = $('header .head div.rbox .nav a');

		var two = $('header .head div.rbox .twonav');



		nav.hover(function(){

			var index = $(this).index();

            var size = two.children("div").size();

            if (index < size) {

                two.show().children("div").eq(index).show().siblings().hide();

            }

		},function(e){

			if( $(e.relatedTarget).parents('.twonav').length < 1 || !$(e.relatedTarget).hasClass('twonav') ){

				two.hide()

			}

		});



		two.hover(function(){

			two.show()

		},function(e){

			if( $(e.relatedTarget).parents('.nav').length < 1 || !$(e.relatedTarget).hasClass('nav') ){

				two.hide()

			}

		});



		$("header .head div.rbox .twonav .box").each(function(){

			var that = $(this);

			var li = that.children("ul").children("li");

			var cent = that.children(".content").children("div");



			li.hover(function(){

				var index = $(this).index();

				$(this).addClass('on').siblings().removeClass("on");

				cent.eq(index).show().siblings().hide()

			}).eq(0).trigger('mouseenter')



		})



	},

	effect:function(){

        $('.index-banner .bd li').css({position:'absolute','left':0,'top':0,display:'none'})
        $('.index-banner').slide({
            mainCell:'.bdd',
            startFun:function(i){
                $('.index-banner .bd li').eq(i).show().siblings().hide()
            }
        });

        if( $('.index-banner')[0] ){
            $('.footer').hide()
        }

		$('.index-home .dot').click(function(e){

			e.preventDefault();

			$(this).fadeOut(300,function(){

				$('.index-slider').animate({top:-840},800,function(){

					$('.index-fuwu .dot').fadeIn(300);
                    $('.footer').show()

				})

			})

		})

		$('.index-fuwu .dot').fadeOut().click(function(e){

			e.preventDefault();

			$(this).fadeOut(300,function(){

				$('.index-slider').animate({top:0},800,function(){

					$('.index-home .dot').fadeIn(300)
					 $('.footer').hide()
				})

			})

		})

	},

	weixin:function(){

		$('.broad-box .weixin').click(function(e){

			e.preventDefault();

			if( !$(this).hasClass('active') ){

				$('.weixin-box').stop(true,true).fadeIn(300)

			}else{

				$('.weixin-box').stop(true,true).fadeOut(300)

			}

			$(this).toggleClass('active');

		})

        $('.broad-box').mouseleave(function(){
            $('.broad-box .weixin-box').fadeOut(300)
            $('.broad-box .weixin').removeClass("active")
        })

	},
    inner:function(){
        var tab = $('.service-tab');
        var a = tab.children("a");
        var num = 0;

        tab.children("a").each(function(index){
            if( $(this).hasClass('active') ){
                num = index;
                $(this).addClass('on')
            }
        });

        tab.children("a").each(function(){
            var hm = $(this).html();
            $(this).html('<p>'+hm+'</p><span></span>')
        })

        tab.children("a").hover(function(){
            cut( $(this) )
        })

        tab.mouseleave(function(){
            cut( a.eq(num) )
        })

        function cut(cum){
            cum.addClass('on').children("span").stop(true,true).animate({top:0},300);
            cum.siblings('a').removeClass("on").children("span").stop(true,true).animate({top:80},300);
        }

    },
    navAn:function(){
        var tab = $('.nav');
        var a = tab.children("a");
        tab.children("a").hover(function(){
            cut( $(this) )
        })

        tab.mouseleave(function(){
            a.removeClass("active").children("span").stop(true,true).animate({top:50},300);
        })

        function cut(cum){
            cum.addClass('active').children("span").stop(true,true).animate({top:0},300);
            cum.siblings('a').removeClass("active").children("span").stop(true,true).animate({top:50},300);
        }
    },
	init:function(){

		this.nav();
        this.navAn();
		this.effect();

		this.weixin();
        this.inner();

	}

}

// 7.21
$(function(){
    indexWheel();
})

// 滚轮
function getWheel(evt){
    var e = evt || window.evt;
    if(e.wheelDelta){
        return e.wheelDelta
    }else if(e.detail){
        return -evt.detail*40
    }
}

// 添加事件
function addEvent(obj,type,fn){
    if(obj.addEventListener){
        obj.addEventListener(type,fn,false)
    }else if(obj.attachEvent){
        obj.attachEvent('on'+type,fn)
    }
}

function indexWheel(){
    var bloor = true;
    function scroll(evt){
        var param = getWheel(evt);
        if( bloor ){
            bloor = false;
            setTimeout(function(){ bloor = true },1000)
            if(param < 0){
                $('.index-home .dot').trigger('click')
            }else if( param > 0){
                $('.index-fuwu .dot').trigger('click')
            }
        }
    }

    if( $('.index-slider')[0] ){
        addEvent(document,'mousewheel',scroll);
        addEvent(document,'DOMMouseScroll',scroll)
    }
}


// 2015.8.5
$(function(){
    
    inputClick()
    inputShow()

    if (!('placeholder' in document.createElement('input'))) { 
        inputFocus()
    }
})

$(window).load(function(){
    inputShow()
})

String.prototype.trim = function () {
    return this.replace(/^\s\s*/, '' ).replace(/\s\s*$/, '' );
}

function inputClick(){
    $('.y-inputshow,.yindex-inputshow').each(function(){
        $(this).click(function(){
            $(this).hide();
            $(this).next('input').trigger('focus')
        })
        
    })
}

function inputShow(){
    $('.y-inputshow,.yindex-inputshow').each(function(){
        if( $(this).next('input').val().trim().length > 0 ){
            $(this).hide()
        };
        
    })
}

function inputFocus(){
    $('#zhongliang,#mudidi,#yuanjidi').each(function(){
        var txt = $(this).attr('placeholder');
        $(this).on({
            'focus':function(){
                if( $(this).val() == txt ){
                    $(this).val('').removeClass('inputActive')
                }
            },
            'blur':function(){
                if( $(this).val() == '' ){
                    $(this).val(txt).addClass('inputActive')
                }
            }
        })
        if( $(this).val() == '' ){
            $(this).val(txt).addClass('inputActive')
        }
    })
}




// add by zhangbo on 20150818
// 电话号码验证
function checkTel(phone){
    var isPhone = /^([0-9]{3,4}-)?[0-9]{7,8}$/;
    var isMob = /^1[3|4|5|6|7|8][0-9]\d{8}$/;
    var other= /^(\(\d{3,4}\)|\d{3,4}-|\s)?\d{7,14}$/;

    if(isMob.test(phone) || isPhone.test(phone)||other.test(phone)) {
        return true;
    } else{
        return false;
    }
}

function checkMob(phone){
    var isMob = /^1[3|4|5|6|7|8][0-9]\d{8}$/;
    if(isMob.test(phone)) {
        return true;
    } else{
        return false;
    }
}
// end by zhangbo
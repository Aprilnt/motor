			// 省市县三级联动方法函数
			// 省的下拉框的函数
			function selectProvince(labelAttr){
				$(labelAttr).select2({
					ajax: {
						language: "zh-CN", //设置 提示语言
					    url: "/noob/region/provinceQuery.action",
					    data: function (params) {
					        var query = {
					          province: params.term,
					        }
					        return query;
					      },
					   
					      processResults: function (data) {
					          return {
					            results: data
					          };
					        },
					        cache: true
					  },
					  
					  placeholder: '请输入省',
					  escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
					  minimumInputLength: 0,
					  templateResult: function formatRepo(repo){
					  	  return repo.text;  
					  }, 
					  templateSelection:function formatRepoSelection(repo){
						  return repo.text;
					  }
				});
				
			}
			
			
			
			// 市的下拉框
			function selectCity(labelAttr){
				$(labelAttr+"_city").select2({
					ajax: {
						language: "zh-CN", //设置 提示语言
					    url: "/noob/region/cityQuery.action",
					    data: function (params) {
					        var query = {
					          province : $(labelAttr+"_province").val(),
					          city : params.term,
					        }
					        return query;
					      },
					   
					      processResults: function (data) {
					          return {
					            results: data
					          };
					        },
					        cache: true
					  },
					  
					  placeholder: '请输入市',
					  escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
					  minimumInputLength: 0,
					  templateResult: function formatRepo(repo){
					  	  return repo.text;  
					  }, 
					  templateSelection:function formatRepoSelection(repo){
						  return repo.text;
					  }
				});
			}
			
			
			// 区的下拉框
			function selectDistrict(labelAttr){
				$(labelAttr+"_district").select2({
					ajax: {
						language: "zh-CN", //设置 提示语言
					    url: "/noob/region/districtQuery.action",
					    data: function (params) {
					        var query = {
					          province : $(labelAttr+"_province").val(),
					          city : $(labelAttr+"_city").val(),
					          district : params.term,
					        }
					        return query;
					      },
					   
					      processResults: function (data) {
					          return {
					            results: data
					          };
					        },
					        cache: true
					  },
					  
					  placeholder: '请输入县/区',
					  escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
					  minimumInputLength: 0,
					  templateResult: function formatRepo(repo){
					  	  return repo.text;  
					  }, 
					  templateSelection:function formatRepoSelection(repo){
						  return repo.text;
					  }
				});
			}
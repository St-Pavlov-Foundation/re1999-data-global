module("modules.logic.help.view.HelpPageTabView", package.seeall)

local var_0_0 = class("HelpPageTabView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")
	arg_1_0._govoidepage = gohelper.findChild(arg_1_0.viewGO, "#go_voidepage")
	arg_1_0._gohelpview = gohelper.findChild(arg_1_0.viewGO, "#go_helpview")
	arg_1_0._gocategorycontent = gohelper.findChild(arg_1_0.viewGO, "left/scroll_category/viewport/#go_categorycontent")
	arg_1_0._gostorecategoryitem = gohelper.findChild(arg_1_0.viewGO, "left/scroll_category/viewport/#go_categorycontent/#go_storecategoryitem")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
end

function var_0_0._onOpenView(arg_4_0, arg_4_1)
	if arg_4_1 == ViewName.GuideView then
		arg_4_0:closeThis()
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._goleft = gohelper.findChild(arg_5_0.viewGO, "left")
end

function var_0_0.setVideoFullScreen(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1 ~= true

	gohelper.setActive(arg_6_0._goleft, var_6_0)
	gohelper.setActive(arg_6_0._golefttop, var_6_0)
	gohelper.setActive(arg_6_0._gobtns, var_6_0)
end

function var_0_0.onUpdateParam(arg_7_0)
	local var_7_0 = arg_7_0.viewParam and arg_7_0.viewParam.defaultShowId

	if var_7_0 then
		local var_7_1 = lua_help_page_tab.configDict[var_7_0]

		if var_7_1 then
			local var_7_2 = var_7_1.mainTitleId
			local var_7_3 = tabletool.indexOf(arg_7_0._tagDataList[var_7_2], var_7_1)

			if arg_7_0._curSelectMainIndex == var_7_2 then
				arg_7_0._curSelectSubIndex = nil

				arg_7_0:_onSubBtnClick(var_7_3)
				arg_7_0:_btn_tween_open_end()
			else
				arg_7_0:_onBtnClick({
					index = var_7_2,
					subIndex = var_7_3
				})
			end
		end
	end
end

function var_0_0.onOpen(arg_8_0)
	if arg_8_0.viewContainer then
		arg_8_0:addEventCb(arg_8_0.viewContainer, HelpEvent.UIPageTabSelectChange, arg_8_0._onVoideFullScreenChange, arg_8_0)
		NavigateMgr.instance:addEscape(arg_8_0.viewContainer.viewName, arg_8_0.closeThis, arg_8_0)
	end

	arg_8_0:setPageTabCfg(nil)
end

function var_0_0.onOpenFinish(arg_9_0)
	arg_9_0._tagDataList = {}

	local var_9_0 = arg_9_0.viewParam and arg_9_0.viewParam.isGMShowAll or false
	local var_9_1 = arg_9_0.viewParam and arg_9_0.viewParam.defaultShowId

	arg_9_0._matchGuideId = nil
	arg_9_0._matchAllPage = false

	if arg_9_0.viewParam and arg_9_0.viewParam.guideId then
		arg_9_0._matchGuideId = tonumber(arg_9_0.viewParam.guideId)
		arg_9_0._matchAllPage = arg_9_0.viewParam.matchAllPage
	end

	local var_9_2 = {}
	local var_9_3

	for iter_9_0, iter_9_1 in ipairs(lua_help_page_tab.configList) do
		if iter_9_1.parentId ~= 0 and arg_9_0:checkIsNeedShowPageTabCfg(iter_9_1, var_9_0) then
			if not var_9_2[iter_9_1.parentId] then
				local var_9_4 = lua_help_page_tab.configDict[iter_9_1.parentId] or iter_9_1

				var_9_2[iter_9_1.parentId] = {
					id = var_9_4.id,
					sortIdx = var_9_4.sortIdx,
					config = var_9_4,
					childCfgList = {}
				}
			end

			table.insert(var_9_2[iter_9_1.parentId].childCfgList, iter_9_1)

			if var_9_1 == iter_9_1.id then
				var_9_3 = iter_9_1
			end
		end
	end

	for iter_9_2, iter_9_3 in pairs(var_9_2) do
		table.sort(var_9_2[iter_9_2].childCfgList, var_0_0._sortSubConfig)
		table.insert(arg_9_0._tagDataList, var_9_2[iter_9_2])
	end

	table.sort(arg_9_0._tagDataList, var_0_0._sortConfig)

	arg_9_0._mainBtnTbList = arg_9_0:getUserDataTb_()
	arg_9_0._subBtnHeightList = {}
	arg_9_0._subBtnTbList = arg_9_0:getUserDataTb_()

	gohelper.CreateObjList(arg_9_0, arg_9_0._onMainBtnShow, arg_9_0._tagDataList, arg_9_0._gocategorycontent, arg_9_0._gostorecategoryitem)

	if #arg_9_0._tagDataList > 0 then
		local var_9_5 = 1
		local var_9_6 = 1

		if var_9_3 then
			var_9_5 = var_9_3.mainTitleId
			var_9_6 = tabletool.indexOf(arg_9_0._tagDataList[var_9_5], var_9_3)

			arg_9_0:_onBtnClick({
				index = var_9_5,
				subIndex = var_9_6
			})
		else
			recthelper.setHeight(arg_9_0._mainBtnTbList[1].transform, 130)
			recthelper.setHeight(arg_9_0._mainBtnTbList[1].go_childcategoryTrs, 0)

			arg_9_0._curSelectMainIndex = var_9_5
			arg_9_0._curSelectSubIndex = nil

			arg_9_0:_refreshMainBtnState()
			arg_9_0:_onSubBtnClick(var_9_6)
			gohelper.setActive(arg_9_0._mainBtnTbList[1].go_line, false)
			arg_9_0:_btn_tween_open_end()

			arg_9_0._curSelectMainIndex = nil
		end
	end
end

function var_0_0._onVoideFullScreenChange(arg_10_0, arg_10_1)
	arg_10_0:setPageTabCfg(arg_10_1)
end

function var_0_0.setPageTabCfg(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1 and arg_11_1.showType or -1

	gohelper.setActive(arg_11_0._govoidepage, var_11_0 == HelpEnum.PageTabShowType.Video)
	gohelper.setActive(arg_11_0._gohelpview, var_11_0 == HelpEnum.PageTabShowType.HelpView)
end

function var_0_0.checkIsNeedShowPageTabCfg(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1 and arg_12_1.showType
	local var_12_1 = arg_12_1 and arg_12_1.helpId

	if var_12_0 == HelpEnum.PageTabShowType.HelpView then
		return arg_12_0:_checkHelpViewByHelpId(var_12_1)
	elseif var_12_0 == HelpEnum.PageTabShowType.Video then
		return arg_12_0:_checkHelpVideoById(var_12_1)
	end

	return false
end

function var_0_0._checkHelpViewByHelpId(arg_13_0, arg_13_1)
	local var_13_0 = HelpConfig.instance:getHelpCO(arg_13_1)

	if not var_13_0 or string.nilorempty(var_13_0.page) then
		logError("请检查帮助说明配置" .. tostring(arg_13_1) .. "相关配置是否完整！")

		return false
	end

	local var_13_1 = string.split(var_13_0.page, "#")

	if #var_13_1 < 1 then
		logError("请检查帮助界面" .. tostring(arg_13_1) .. "相关配置是否完整！")

		return false
	end

	for iter_13_0 = 1, #var_13_1 do
		local var_13_2 = HelpConfig.instance:getHelpPageCo(tonumber(var_13_1[iter_13_0]))

		if arg_13_0.viewContainer:checkHelpPageCfg(var_13_2, arg_13_0._matchAllPage, arg_13_0._matchGuideId) then
			return true
		end
	end

	return false
end

function var_0_0._checkHelpVideoById(arg_14_0, arg_14_1)
	local var_14_0 = HelpConfig.instance:getHelpVideoCO(arg_14_1)

	if not var_14_0 or string.nilorempty(var_14_0.videopath) then
		logError("请检查【export_帮助视频】" .. tostring(arg_14_1) .. "相关配置是否完整！")

		return false
	end

	return arg_14_0.viewContainer:checkHelpVideoCfg(var_14_0, arg_14_0._matchAllPage, arg_14_0._matchGuideId)
end

function var_0_0._onMainBtnShow(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_0:getUserDataTb_()
	local var_15_1 = arg_15_1.transform

	var_15_0.gameObject = arg_15_1
	var_15_0.go = arg_15_1
	var_15_0.goTrs = var_15_1
	var_15_0.transform = var_15_1
	var_15_0.index = arg_15_3
	var_15_0.data = arg_15_2

	local var_15_2 = arg_15_2.config

	var_15_0.go_selected = gohelper.findChild(arg_15_1, "go_selected")
	var_15_0.go_unselected = gohelper.findChild(arg_15_1, "go_unselected")
	var_15_0.go_childcategory = gohelper.findChild(arg_15_1, "go_childcategory")
	var_15_0.go_childitem = gohelper.findChild(arg_15_1, "go_childcategory/go_childitem")
	var_15_0.go_line = gohelper.findChild(arg_15_1, "go_line")
	var_15_0.go_lineTrs = var_15_0.go_line.transform
	var_15_0.go_childcategoryTrs = var_15_0.go_childcategory.transform

	local var_15_3 = gohelper.findChild(arg_15_1, "clickArea")
	local var_15_4 = gohelper.getClickWithAudio(var_15_3, AudioEnum.UI.UI_transverse_tabs_click)
	local var_15_5 = gohelper.findChildText(arg_15_1, "go_unselected/txt_itemcn1")
	local var_15_6 = gohelper.findChildText(arg_15_1, "go_unselected/txt_itemen1")
	local var_15_7 = gohelper.findChildText(arg_15_1, "go_selected/txt_itemcn2")
	local var_15_8 = gohelper.findChildText(arg_15_1, "go_selected/txt_itemen2")

	var_15_5.text = var_15_2.title
	var_15_6.text = var_15_2.title_en
	var_15_7.text = var_15_2.title
	var_15_8.text = var_15_2.title_en
	arg_15_0._subBelongIndex = arg_15_3
	arg_15_0._subBtnPosY = -60

	gohelper.CreateObjList(arg_15_0, arg_15_0._onSubBtnShow, arg_15_2.childCfgList, var_15_0.go_childcategory, var_15_0.go_childitem)

	arg_15_0._subBtnHeightList[arg_15_3] = math.abs(arg_15_0._subBtnPosY + 70)

	table.insert(arg_15_0._mainBtnTbList, var_15_0)
	arg_15_0:removeClickCb(var_15_4)
	arg_15_0:addClickCb(var_15_4, arg_15_0._onBtnClick, arg_15_0, var_15_0)
end

function var_0_0._onBtnClick(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.index
	local var_16_1 = arg_16_1.subIndex or 1

	if arg_16_0._curSelectMainIndex == var_16_0 then
		if arg_16_0._btnAniTweenId then
			ZProj.TweenHelper.KillById(arg_16_0._btnAniTweenId)
		end

		arg_16_0._btnAniTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.3, arg_16_0._onBtnAniFrameCallback, arg_16_0._btn_tween_end, arg_16_0)

		return
	end

	if arg_16_0._curSelectMainIndex then
		recthelper.setHeight(arg_16_0._mainBtnTbList[arg_16_0._curSelectMainIndex].transform, 130)
		recthelper.setHeight(arg_16_0._mainBtnTbList[arg_16_0._curSelectMainIndex].go_childcategoryTrs, 0)
	end

	arg_16_0._curSelectMainIndex = var_16_0
	arg_16_0._curSelectSubIndex = nil

	arg_16_0:_refreshMainBtnState()
	arg_16_0:_onSubBtnClick(var_16_1)

	if arg_16_0._btnAniTweenId then
		ZProj.TweenHelper.KillById(arg_16_0._btnAniTweenId)
	end

	gohelper.setActive(arg_16_0._mainBtnTbList[arg_16_0._curSelectMainIndex].go_line, true)

	arg_16_0._btnAniTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.3, arg_16_0._onBtnAniFrameCallback, arg_16_0._btn_tween_open_end, arg_16_0)
end

function var_0_0._onBtnAniFrameCallback(arg_17_0, arg_17_1)
	recthelper.setHeight(arg_17_0._mainBtnTbList[arg_17_0._curSelectMainIndex].transform, 130 + arg_17_0._subBtnHeightList[arg_17_0._curSelectMainIndex] * arg_17_1)
	recthelper.setHeight(arg_17_0._mainBtnTbList[arg_17_0._curSelectMainIndex].go_childcategoryTrs, arg_17_0._subBtnHeightList[arg_17_0._curSelectMainIndex] * arg_17_1)
end

function var_0_0.scrollItemIsVisible(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_1.transform:InverseTransformPoint(arg_18_2.transform.position).y + recthelper.getHeight(arg_18_2.transform) / 2

	if var_18_0 >= 65 or var_18_0 <= -785 then
		recthelper.setAnchorY(arg_18_0._gocategorycontent.transform, 130 * (arg_18_0._curSelectMainIndex - 1) - 60)
	end
end

function var_0_0._btn_tween_open_end(arg_19_0)
	arg_19_0:scrollItemIsVisible(gohelper.findChild(arg_19_0.viewGO, "left/scroll_category"), arg_19_0._mainBtnTbList[arg_19_0._curSelectMainIndex])
end

function var_0_0._btn_tween_end(arg_20_0)
	gohelper.setActive(arg_20_0._mainBtnTbList[arg_20_0._curSelectMainIndex].go_line, false)

	arg_20_0._curSelectMainIndex = nil
end

function var_0_0._refreshMainBtnState(arg_21_0)
	if arg_21_0._mainBtnTbList then
		local var_21_0 = arg_21_0._mainBtnTbList[arg_21_0._curSelectMainIndex]

		for iter_21_0, iter_21_1 in ipairs(arg_21_0._mainBtnTbList) do
			local var_21_1 = iter_21_1 == var_21_0

			gohelper.setActive(iter_21_1.go_line, var_21_1)
			gohelper.setActive(iter_21_1.go_unselected, not var_21_1)
			gohelper.setActive(iter_21_1.go_selected, var_21_1)
			gohelper.setActive(iter_21_1.go_childcategory, var_21_1)
		end
	end
end

function var_0_0._onSubBtnShow(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = arg_22_0:getUserDataTb_()
	local var_22_1 = arg_22_1.transform

	var_22_0.gameObject = arg_22_1
	var_22_0.go = arg_22_1
	var_22_0.transform = var_22_1
	var_22_0.goTrs = var_22_1
	var_22_0.data = arg_22_2
	var_22_0.index = arg_22_3
	var_22_0.go_selected = gohelper.findChild(arg_22_1, "go_selected")
	var_22_0.go_unselected = gohelper.findChild(arg_22_1, "go_unselected")

	recthelper.setAnchorY(var_22_1, arg_22_0._subBtnPosY)

	arg_22_0._subBtnPosY = arg_22_0._subBtnPosY - 110

	local var_22_2 = gohelper.findChild(arg_22_1, "clickArea")
	local var_22_3 = gohelper.getClickWithAudio(var_22_2, AudioEnum.UI.UI_transverse_tabs_click)
	local var_22_4 = gohelper.findChildText(arg_22_1, "go_unselected/txt_itemcn1")
	local var_22_5 = gohelper.findChildText(arg_22_1, "go_unselected/txt_itemen1")
	local var_22_6 = gohelper.findChildText(arg_22_1, "go_selected/txt_itemcn2")
	local var_22_7 = gohelper.findChildText(arg_22_1, "go_selected/txt_itemen2")

	var_22_4.text = arg_22_2.title
	var_22_5.text = arg_22_2.title_en
	var_22_6.text = arg_22_2.title
	var_22_7.text = arg_22_2.title_en

	if not arg_22_0._subBtnTbList[arg_22_0._subBelongIndex] then
		arg_22_0._subBtnTbList[arg_22_0._subBelongIndex] = {}
	end

	table.insert(arg_22_0._subBtnTbList[arg_22_0._subBelongIndex], var_22_0)
	arg_22_0:removeClickCb(var_22_3)
	arg_22_0:addClickCb(var_22_3, arg_22_0._onSubBtnClick, arg_22_0, arg_22_3)
end

function var_0_0._onSubBtnClick(arg_23_0, arg_23_1)
	if arg_23_0._curSelectSubIndex == arg_23_1 then
		return
	end

	arg_23_0._curSelectSubIndex = arg_23_1
	arg_23_0._curSelectSubData = arg_23_0._tagDataList[arg_23_0._curSelectMainIndex].childCfgList[arg_23_1]

	arg_23_0:_refreshSubBtnState()

	if arg_23_0.viewContainer then
		arg_23_0.viewContainer:dispatchEvent(HelpEvent.UIPageTabSelectChange, arg_23_0._curSelectSubData)
	end
end

function var_0_0._refreshSubBtnState(arg_24_0)
	if arg_24_0._subBtnTbList then
		local var_24_0 = arg_24_0._subBtnTbList[arg_24_0._curSelectMainIndex]
		local var_24_1 = var_24_0[arg_24_0._curSelectSubIndex]

		for iter_24_0, iter_24_1 in ipairs(var_24_0) do
			local var_24_2 = iter_24_1 == var_24_1

			gohelper.setActive(iter_24_1.go_unselected, not var_24_2)
			gohelper.setActive(iter_24_1.go_selected, var_24_2)
		end
	end
end

function var_0_0._sortConfig(arg_25_0, arg_25_1)
	return var_0_0._sortSubConfig(arg_25_0, arg_25_1)
end

function var_0_0._sortSubConfig(arg_26_0, arg_26_1)
	if arg_26_0.sortIdx ~= arg_26_1.sortIdx then
		return arg_26_0.sortIdx < arg_26_1.sortIdx
	end

	if arg_26_0.id ~= arg_26_1.id then
		return arg_26_0.id < arg_26_1.id
	end
end

function var_0_0.onClose(arg_27_0)
	if arg_27_0._btnAniTweenId then
		ZProj.TweenHelper.KillById(arg_27_0._btnAniTweenId)
	end
end

function var_0_0.onDestroyView(arg_28_0)
	return
end

return var_0_0

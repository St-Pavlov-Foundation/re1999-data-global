module("modules.logic.help.view.HelpPageTabView", package.seeall)

slot0 = class("HelpPageTabView", BaseView)

function slot0.onInitView(slot0)
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")
	slot0._govoidepage = gohelper.findChild(slot0.viewGO, "#go_voidepage")
	slot0._gohelpview = gohelper.findChild(slot0.viewGO, "#go_helpview")
	slot0._gocategorycontent = gohelper.findChild(slot0.viewGO, "left/scroll_category/viewport/#go_categorycontent")
	slot0._gostorecategoryitem = gohelper.findChild(slot0.viewGO, "left/scroll_category/viewport/#go_categorycontent/#go_storecategoryitem")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0._onOpenView, slot0)
end

function slot0.removeEvents(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, slot0._onOpenView, slot0)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.GuideView then
		slot0:closeThis()
	end
end

function slot0._editableInitView(slot0)
	slot0._goleft = gohelper.findChild(slot0.viewGO, "left")
end

function slot0.setVideoFullScreen(slot0, slot1)
	slot2 = slot1 ~= true

	gohelper.setActive(slot0._goleft, slot2)
	gohelper.setActive(slot0._golefttop, slot2)
	gohelper.setActive(slot0._gobtns, slot2)
end

function slot0.onUpdateParam(slot0)
	if slot0.viewParam and slot0.viewParam.defaultShowId and lua_help_page_tab.configDict[slot1] then
		slot3 = slot2.mainTitleId

		if slot0._curSelectMainIndex == slot3 then
			slot0._curSelectSubIndex = nil

			slot0:_onSubBtnClick(tabletool.indexOf(slot0._tagDataList[slot3], slot2))
			slot0:_btn_tween_open_end()
		else
			slot0:_onBtnClick({
				index = slot3,
				subIndex = slot4
			})
		end
	end
end

function slot0.onOpen(slot0)
	if slot0.viewContainer then
		slot0:addEventCb(slot0.viewContainer, HelpEvent.UIPageTabSelectChange, slot0._onVoideFullScreenChange, slot0)
		NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0.closeThis, slot0)
	end

	slot0:setPageTabCfg(nil)
end

function slot0.onOpenFinish(slot0)
	slot0._tagDataList = {}
	slot1 = slot0.viewParam and slot0.viewParam.isGMShowAll or false
	slot2 = slot0.viewParam and slot0.viewParam.defaultShowId
	slot0._matchGuideId = nil
	slot0._matchAllPage = false

	if slot0.viewParam and slot0.viewParam.guideId then
		slot0._matchGuideId = tonumber(slot0.viewParam.guideId)
		slot0._matchAllPage = slot0.viewParam.matchAllPage
	end

	slot3 = {}
	slot4 = nil

	for slot8, slot9 in ipairs(lua_help_page_tab.configList) do
		if slot9.parentId ~= 0 and slot0:checkIsNeedShowPageTabCfg(slot9, slot1) then
			if not slot3[slot9.parentId] then
				slot10 = lua_help_page_tab.configDict[slot9.parentId] or slot9
				slot3[slot9.parentId] = {
					id = slot10.id,
					sortIdx = slot10.sortIdx,
					config = slot10,
					childCfgList = {}
				}
			end

			table.insert(slot3[slot9.parentId].childCfgList, slot9)

			if slot2 == slot9.id then
				slot4 = slot9
			end
		end
	end

	for slot8, slot9 in pairs(slot3) do
		table.sort(slot3[slot8].childCfgList, uv0._sortSubConfig)
		table.insert(slot0._tagDataList, slot3[slot8])
	end

	table.sort(slot0._tagDataList, uv0._sortConfig)

	slot0._mainBtnTbList = slot0:getUserDataTb_()
	slot0._subBtnHeightList = {}
	slot0._subBtnTbList = slot0:getUserDataTb_()

	gohelper.CreateObjList(slot0, slot0._onMainBtnShow, slot0._tagDataList, slot0._gocategorycontent, slot0._gostorecategoryitem)

	if #slot0._tagDataList > 0 then
		slot5 = 1
		slot6 = 1

		if slot4 then
			slot5 = slot4.mainTitleId

			slot0:_onBtnClick({
				index = slot5,
				subIndex = tabletool.indexOf(slot0._tagDataList[slot5], slot4)
			})
		else
			recthelper.setHeight(slot0._mainBtnTbList[1].transform, 130)
			recthelper.setHeight(slot0._mainBtnTbList[1].go_childcategoryTrs, 0)

			slot0._curSelectMainIndex = slot5
			slot0._curSelectSubIndex = nil

			slot0:_refreshMainBtnState()
			slot0:_onSubBtnClick(slot6)
			gohelper.setActive(slot0._mainBtnTbList[1].go_line, false)
			slot0:_btn_tween_open_end()

			slot0._curSelectMainIndex = nil
		end
	end
end

function slot0._onVoideFullScreenChange(slot0, slot1)
	slot0:setPageTabCfg(slot1)
end

function slot0.setPageTabCfg(slot0, slot1)
	slot2 = slot1 and slot1.showType or -1

	gohelper.setActive(slot0._govoidepage, slot2 == HelpEnum.PageTabShowType.Video)
	gohelper.setActive(slot0._gohelpview, slot2 == HelpEnum.PageTabShowType.HelpView)
end

function slot0.checkIsNeedShowPageTabCfg(slot0, slot1, slot2)
	if (slot1 and slot1.showType) == HelpEnum.PageTabShowType.HelpView then
		return slot0:_checkHelpViewByHelpId(slot1 and slot1.helpId)
	elseif slot3 == HelpEnum.PageTabShowType.Video then
		return slot0:_checkHelpVideoById(slot4)
	end

	return false
end

function slot0._checkHelpViewByHelpId(slot0, slot1)
	if not HelpConfig.instance:getHelpCO(slot1) or string.nilorempty(slot2.page) then
		logError("请检查帮助说明配置" .. tostring(slot1) .. "相关配置是否完整！")

		return false
	end

	if #string.split(slot2.page, "#") < 1 then
		logError("请检查帮助界面" .. tostring(slot1) .. "相关配置是否完整！")

		return false
	end

	for slot7 = 1, #slot3 do
		if slot0.viewContainer:checkHelpPageCfg(HelpConfig.instance:getHelpPageCo(tonumber(slot3[slot7])), slot0._matchAllPage, slot0._matchGuideId) then
			return true
		end
	end

	return false
end

function slot0._checkHelpVideoById(slot0, slot1)
	if not HelpConfig.instance:getHelpVideoCO(slot1) or string.nilorempty(slot2.videopath) then
		logError("请检查【export_帮助视频】" .. tostring(slot1) .. "相关配置是否完整！")

		return false
	end

	return slot0.viewContainer:checkHelpVideoCfg(slot2, slot0._matchAllPage, slot0._matchGuideId)
end

function slot0._onMainBtnShow(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()
	slot5 = slot1.transform
	slot4.gameObject = slot1
	slot4.go = slot1
	slot4.goTrs = slot5
	slot4.transform = slot5
	slot4.index = slot3
	slot4.data = slot2
	slot6 = slot2.config
	slot4.go_selected = gohelper.findChild(slot1, "go_selected")
	slot4.go_unselected = gohelper.findChild(slot1, "go_unselected")
	slot4.go_childcategory = gohelper.findChild(slot1, "go_childcategory")
	slot4.go_childitem = gohelper.findChild(slot1, "go_childcategory/go_childitem")
	slot4.go_line = gohelper.findChild(slot1, "go_line")
	slot4.go_lineTrs = slot4.go_line.transform
	slot4.go_childcategoryTrs = slot4.go_childcategory.transform
	slot8 = gohelper.getClickWithAudio(gohelper.findChild(slot1, "clickArea"), AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.findChildText(slot1, "go_unselected/txt_itemcn1").text = slot6.title
	gohelper.findChildText(slot1, "go_unselected/txt_itemen1").text = slot6.title_en
	gohelper.findChildText(slot1, "go_selected/txt_itemcn2").text = slot6.title
	gohelper.findChildText(slot1, "go_selected/txt_itemen2").text = slot6.title_en
	slot0._subBelongIndex = slot3
	slot0._subBtnPosY = -60

	gohelper.CreateObjList(slot0, slot0._onSubBtnShow, slot2.childCfgList, slot4.go_childcategory, slot4.go_childitem)

	slot0._subBtnHeightList[slot3] = math.abs(slot0._subBtnPosY + 70)

	table.insert(slot0._mainBtnTbList, slot4)
	slot0:removeClickCb(slot8)
	slot0:addClickCb(slot8, slot0._onBtnClick, slot0, slot4)
end

function slot0._onBtnClick(slot0, slot1)
	slot3 = slot1.subIndex or 1

	if slot0._curSelectMainIndex == slot1.index then
		if slot0._btnAniTweenId then
			ZProj.TweenHelper.KillById(slot0._btnAniTweenId)
		end

		slot0._btnAniTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.3, slot0._onBtnAniFrameCallback, slot0._btn_tween_end, slot0)

		return
	end

	if slot0._curSelectMainIndex then
		recthelper.setHeight(slot0._mainBtnTbList[slot0._curSelectMainIndex].transform, 130)
		recthelper.setHeight(slot0._mainBtnTbList[slot0._curSelectMainIndex].go_childcategoryTrs, 0)
	end

	slot0._curSelectMainIndex = slot2
	slot0._curSelectSubIndex = nil

	slot0:_refreshMainBtnState()
	slot0:_onSubBtnClick(slot3)

	if slot0._btnAniTweenId then
		ZProj.TweenHelper.KillById(slot0._btnAniTweenId)
	end

	gohelper.setActive(slot0._mainBtnTbList[slot0._curSelectMainIndex].go_line, true)

	slot0._btnAniTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.3, slot0._onBtnAniFrameCallback, slot0._btn_tween_open_end, slot0)
end

function slot0._onBtnAniFrameCallback(slot0, slot1)
	recthelper.setHeight(slot0._mainBtnTbList[slot0._curSelectMainIndex].transform, 130 + slot0._subBtnHeightList[slot0._curSelectMainIndex] * slot1)
	recthelper.setHeight(slot0._mainBtnTbList[slot0._curSelectMainIndex].go_childcategoryTrs, slot0._subBtnHeightList[slot0._curSelectMainIndex] * slot1)
end

function slot0.scrollItemIsVisible(slot0, slot1, slot2)
	if slot1.transform:InverseTransformPoint(slot2.transform.position).y + recthelper.getHeight(slot2.transform) / 2 >= 65 or slot3 <= -785 then
		recthelper.setAnchorY(slot0._gocategorycontent.transform, 130 * (slot0._curSelectMainIndex - 1) - 60)
	end
end

function slot0._btn_tween_open_end(slot0)
	slot0:scrollItemIsVisible(gohelper.findChild(slot0.viewGO, "left/scroll_category"), slot0._mainBtnTbList[slot0._curSelectMainIndex])
end

function slot0._btn_tween_end(slot0)
	gohelper.setActive(slot0._mainBtnTbList[slot0._curSelectMainIndex].go_line, false)

	slot0._curSelectMainIndex = nil
end

function slot0._refreshMainBtnState(slot0)
	if slot0._mainBtnTbList then
		for slot5, slot6 in ipairs(slot0._mainBtnTbList) do
			slot7 = slot6 == slot0._mainBtnTbList[slot0._curSelectMainIndex]

			gohelper.setActive(slot6.go_line, slot7)
			gohelper.setActive(slot6.go_unselected, not slot7)
			gohelper.setActive(slot6.go_selected, slot7)
			gohelper.setActive(slot6.go_childcategory, slot7)
		end
	end
end

function slot0._onSubBtnShow(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()
	slot5 = slot1.transform
	slot4.gameObject = slot1
	slot4.go = slot1
	slot4.transform = slot5
	slot4.goTrs = slot5
	slot4.data = slot2
	slot4.index = slot3
	slot4.go_selected = gohelper.findChild(slot1, "go_selected")
	slot4.go_unselected = gohelper.findChild(slot1, "go_unselected")

	recthelper.setAnchorY(slot5, slot0._subBtnPosY)

	slot0._subBtnPosY = slot0._subBtnPosY - 110
	slot7 = gohelper.getClickWithAudio(gohelper.findChild(slot1, "clickArea"), AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.findChildText(slot1, "go_unselected/txt_itemcn1").text = slot2.title
	gohelper.findChildText(slot1, "go_unselected/txt_itemen1").text = slot2.title_en
	gohelper.findChildText(slot1, "go_selected/txt_itemcn2").text = slot2.title
	gohelper.findChildText(slot1, "go_selected/txt_itemen2").text = slot2.title_en

	if not slot0._subBtnTbList[slot0._subBelongIndex] then
		slot0._subBtnTbList[slot0._subBelongIndex] = {}
	end

	table.insert(slot0._subBtnTbList[slot0._subBelongIndex], slot4)
	slot0:removeClickCb(slot7)
	slot0:addClickCb(slot7, slot0._onSubBtnClick, slot0, slot3)
end

function slot0._onSubBtnClick(slot0, slot1)
	if slot0._curSelectSubIndex == slot1 then
		return
	end

	slot0._curSelectSubIndex = slot1
	slot0._curSelectSubData = slot0._tagDataList[slot0._curSelectMainIndex].childCfgList[slot1]

	slot0:_refreshSubBtnState()

	if slot0.viewContainer then
		slot0.viewContainer:dispatchEvent(HelpEvent.UIPageTabSelectChange, slot0._curSelectSubData)
	end
end

function slot0._refreshSubBtnState(slot0)
	if slot0._subBtnTbList then
		slot1 = slot0._subBtnTbList[slot0._curSelectMainIndex]

		for slot6, slot7 in ipairs(slot1) do
			slot8 = slot7 == slot1[slot0._curSelectSubIndex]

			gohelper.setActive(slot7.go_unselected, not slot8)
			gohelper.setActive(slot7.go_selected, slot8)
		end
	end
end

function slot0._sortConfig(slot0, slot1)
	return uv0._sortSubConfig(slot0, slot1)
end

function slot0._sortSubConfig(slot0, slot1)
	if slot0.sortIdx ~= slot1.sortIdx then
		return slot0.sortIdx < slot1.sortIdx
	end

	if slot0.id ~= slot1.id then
		return slot0.id < slot1.id
	end
end

function slot0.onClose(slot0)
	if slot0._btnAniTweenId then
		ZProj.TweenHelper.KillById(slot0._btnAniTweenId)
	end
end

function slot0.onDestroyView(slot0)
end

return slot0

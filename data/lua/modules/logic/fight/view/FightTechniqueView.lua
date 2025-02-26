module("modules.logic.fight.view.FightTechniqueView", package.seeall)

slot0 = class("FightTechniqueView", BaseView)

function slot0.onInitView(slot0)
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")
	slot0._gocategorycontent = gohelper.findChild(slot0.viewGO, "left/scroll_category/viewport/#go_categorycontent")
	slot0._gostorecategoryitem = gohelper.findChild(slot0.viewGO, "left/scroll_category/viewport/#go_categorycontent/#go_storecategoryitem")
	slot0._gocenter = gohelper.findChild(slot0.viewGO, "#go_center")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_center/#simage_icon")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")

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
	slot0._simagebg:LoadImage(ResUrl.getTechniqueBg("banner_di"))
end

function slot0.onUpdateParam(slot0)
	if slot0.viewParam and slot0.viewParam.defaultShowId and lua_fight_technique.configDict[slot1] then
		slot3 = slot2.mainTitleId

		if slot0.cur_select_main_index == slot3 then
			slot0.cur_select_sub_index = nil

			slot0:_onSubBtnClick(tabletool.indexOf(slot0.btn_data_list[slot3], slot2))
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
	slot0.btn_data_list = {}
	slot1 = slot0.viewParam and slot0.viewParam.isGMShowAll or false
	slot2 = slot0.viewParam and slot0.viewParam.defaultShowId
	slot3 = {}
	slot4 = nil

	for slot8, slot9 in ipairs(lua_fight_technique.configList) do
		if slot9.mainTitleId ~= 0 then
			if not slot3[slot9.mainTitleId] then
				slot3[slot9.mainTitleId] = {}
			end

			if slot0:checkIsNeedShowTechnique(slot9, slot1) then
				table.insert(slot3[slot9.mainTitleId], slot9)

				if slot2 == slot9.id then
					slot4 = slot9
				end
			end
		end
	end

	for slot8, slot9 in pairs(slot3) do
		table.sort(slot3[slot8], uv0.sortSubTechniqueConfig)

		if #slot3[slot8] > 0 then
			table.insert(slot0.btn_data_list, slot3[slot8])
		end
	end

	table.sort(slot0.btn_data_list, uv0.sortTechniqueConfig)

	slot0.btn_list = slot0:getUserDataTb_()
	slot0.sub_btn_height = {}
	slot0.btn_sub_list = slot0:getUserDataTb_()

	gohelper.CreateObjList(slot0, slot0._onBtnShow, slot0.btn_data_list, slot0._gocategorycontent, slot0._gostorecategoryitem)

	if #slot0.btn_data_list > 0 then
		slot5 = 1
		slot6 = 1

		if slot4 then
			slot5 = slot4.mainTitleId

			slot0:_onBtnClick({
				index = slot5,
				subIndex = tabletool.indexOf(slot0.btn_data_list[slot5], slot4)
			})
		else
			recthelper.setHeight(slot0.btn_list[1].transform, 130)
			recthelper.setHeight(slot0.btn_list[1].transform:Find("go_childcategory").transform, 0)

			slot0.cur_select_main_index = slot5
			slot0.cur_select_sub_index = nil

			slot0:_detectBtnState()
			slot0:_onSubBtnClick(slot6)
			gohelper.setActive(slot0.btn_list[1].transform:Find("go_line").gameObject, false)
			slot0:_btn_tween_open_end()

			slot0.cur_select_main_index = nil
		end
	end

	FightAudioMgr.instance:obscureBgm(true)
end

function slot0.checkIsNeedShowTechnique(slot0, slot1, slot2)
	if slot1 then
		slot3 = true
		slot4 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)
		slot5 = true
		slot6 = false

		if not string.nilorempty(slot1.displayType) then
			slot5 = slot0:checkCurEpisodeTypeIsMatch(slot1.displayType)
		end

		if not string.nilorempty(slot1.noDisplayType) then
			slot6 = slot0:checkCurEpisodeTypeIsMatch(slot1.noDisplayType)
		end

		return slot5 and not slot6 and (slot2 or string.nilorempty(slot1.condition) or FightViewTechniqueModel.instance:isUnlock(slot1.id))
	end
end

function slot0.checkCurEpisodeTypeIsMatch(slot0, slot1)
	slot3 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) and slot2.type

	if string.split(slot1, "#") then
		for slot8, slot9 in ipairs(slot4) do
			if tonumber(slot9) == slot3 then
				return true
			end
		end
	end

	return false
end

function slot0._onBtnShow(slot0, slot1, slot2, slot3)
	slot4 = slot1.transform
	slot5 = gohelper.getClickWithAudio(slot4:Find("clickArea").gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	slot4:Find("go_unselected/txt_itemcn1"):GetComponent(gohelper.Type_TextMesh).text = slot2[1].mainTitle_cn
	slot4:Find("go_unselected/txt_itemen1"):GetComponent(gohelper.Type_TextMesh).text = slot2[1].mainTitle_en
	slot4:Find("go_selected/txt_itemcn2"):GetComponent(gohelper.Type_TextMesh).text = slot2[1].mainTitle_cn
	slot4:Find("go_selected/txt_itemen2"):GetComponent(gohelper.Type_TextMesh).text = slot2[1].mainTitle_en
	slot0.sub_belong_index = slot3
	slot0.sub_btn_pos_y = -60

	gohelper.CreateObjList(slot0, slot0._onSubBtnShow, slot2, slot4:Find("go_childcategory").gameObject, slot4:Find("go_childcategory/go_childitem").gameObject)

	slot0.sub_btn_height[slot3] = math.abs(slot0.sub_btn_pos_y + 70)

	table.insert(slot0.btn_list, slot1)
	slot0:removeClickCb(slot5)
	slot0:addClickCb(slot5, slot0._onBtnClick, slot0, {
		index = slot3
	})
end

function slot0._onBtnClick(slot0, slot1)
	slot3 = slot1.subIndex or 1

	if slot0.cur_select_main_index == slot1.index then
		if slot0._btn_ani then
			ZProj.TweenHelper.KillById(slot0._btn_ani)
		end

		slot0._btn_ani = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.3, slot0._onBtnAniFrameCallback, slot0._btn_tween_end, slot0)

		return
	end

	if slot0.cur_select_main_index then
		recthelper.setHeight(slot0.btn_list[slot0.cur_select_main_index].transform, 130)
		recthelper.setHeight(slot0.btn_list[slot0.cur_select_main_index].transform:Find("go_childcategory").transform, 0)
	end

	slot0.cur_select_main_index = slot2
	slot0.cur_select_sub_index = nil

	slot0:_detectBtnState()
	slot0:_onSubBtnClick(slot3)

	if slot0._btn_ani then
		ZProj.TweenHelper.KillById(slot0._btn_ani)
	end

	gohelper.setActive(slot0.btn_list[slot0.cur_select_main_index].transform:Find("go_line").gameObject, true)

	slot0._btn_ani = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.3, slot0._onBtnAniFrameCallback, slot0._btn_tween_open_end, slot0)
end

function slot0._onBtnAniFrameCallback(slot0, slot1)
	recthelper.setHeight(slot0.btn_list[slot0.cur_select_main_index].transform, 130 + slot0.sub_btn_height[slot0.cur_select_main_index] * slot1)
	recthelper.setHeight(slot0.btn_list[slot0.cur_select_main_index].transform:Find("go_childcategory").transform, slot0.sub_btn_height[slot0.cur_select_main_index] * slot1)
end

function slot0.scrollItemIsVisible(slot0, slot1, slot2)
	if slot1.transform:InverseTransformPoint(slot2.transform.position).y + recthelper.getHeight(slot2.transform) / 2 >= 65 or slot3 <= -785 then
		recthelper.setAnchorY(slot0._gocategorycontent.transform, 130 * (slot0.cur_select_main_index - 1) - 60)
	end
end

function slot0._btn_tween_open_end(slot0)
	slot0:scrollItemIsVisible(gohelper.findChild(slot0.viewGO, "left/scroll_category"), slot0.btn_list[slot0.cur_select_main_index])
end

function slot0._btn_tween_end(slot0)
	gohelper.setActive(slot0.btn_list[slot0.cur_select_main_index].transform:Find("go_line").gameObject, false)

	slot0.cur_select_main_index = nil
end

function slot0._detectBtnState(slot0)
	if slot0.btn_list then
		for slot4, slot5 in ipairs(slot0.btn_list) do
			slot6 = slot5 == slot0.btn_list[slot0.cur_select_main_index]
			slot7 = slot5.transform

			gohelper.setActive(slot7:Find("go_line").gameObject, slot6)
			gohelper.setActive(slot7:Find("go_unselected").gameObject, not slot6)
			gohelper.setActive(slot7:Find("go_selected").gameObject, slot6)
			gohelper.setActive(slot7:Find("go_childcategory").gameObject, slot6)
		end
	end
end

function slot0._onSubBtnShow(slot0, slot1, slot2, slot3)
	slot4 = slot1.transform

	recthelper.setAnchorY(slot4, slot0.sub_btn_pos_y)

	slot0.sub_btn_pos_y = slot0.sub_btn_pos_y - 110
	slot5 = gohelper.getClickWithAudio(slot4:Find("clickArea").gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	slot4:Find("go_unselected/txt_itemcn1"):GetComponent(gohelper.Type_TextMesh).text = slot2.title_cn
	slot4:Find("go_unselected/txt_itemen1"):GetComponent(gohelper.Type_TextMesh).text = slot2.title_en
	slot4:Find("go_selected/txt_itemcn2"):GetComponent(gohelper.Type_TextMesh).text = slot2.title_cn
	slot4:Find("go_selected/txt_itemen2"):GetComponent(gohelper.Type_TextMesh).text = slot2.title_en

	if not slot0.btn_sub_list[slot0.sub_belong_index] then
		slot0.btn_sub_list[slot0.sub_belong_index] = {}
	end

	table.insert(slot0.btn_sub_list[slot0.sub_belong_index], slot1)
	slot0:removeClickCb(slot5)
	slot0:addClickCb(slot5, slot0._onSubBtnClick, slot0, slot3)
end

function slot0._onSubBtnClick(slot0, slot1)
	if slot0.cur_select_sub_index == slot1 then
		return
	end

	slot0.cur_select_sub_index = slot1
	slot0.cur_select_data = slot0.btn_data_list[slot0.cur_select_main_index][slot1]

	slot0:_detectSubBtnState()
	slot0:_refreshContentData()
end

function slot0._detectSubBtnState(slot0)
	if slot0.btn_sub_list then
		for slot4, slot5 in ipairs(slot0.btn_sub_list[slot0.cur_select_main_index]) do
			slot6 = slot5 == slot0.btn_sub_list[slot0.cur_select_main_index][slot0.cur_select_sub_index]
			slot7 = slot5.transform

			gohelper.setActive(slot7:Find("go_unselected").gameObject, not slot6)
			gohelper.setActive(slot7:Find("go_selected").gameObject, slot6)
		end
	end
end

function slot0.sortTechniqueConfig(slot0, slot1)
	return slot0[1].mainTitleId < slot1[1].mainTitleId
end

function slot0.sortSubTechniqueConfig(slot0, slot1)
	return slot0.subTitleId < slot1.subTitleId
end

function slot0._refreshContentData(slot0)
	if not (slot0.viewParam and slot0.viewParam.isGMShowAll or false) then
		FightViewTechniqueModel.instance:readTechnique(slot0.cur_select_data.id)
	end

	slot0._simageicon:LoadImage(ResUrl.getTechniqueLangIcon(slot0.cur_select_data.picture1))

	slot2 = string.split(slot0.cur_select_data.content1, "|")

	for slot6, slot7 in pairs(lua_fight_technique.configDict) do
		if gohelper.findChild(slot0.viewGO, "#go_center/content/" .. slot7.id) then
			gohelper.setActive(slot8, slot7.id == slot0.cur_select_data.id)

			if slot0.cur_select_data.id == slot7.id then
				for slot12, slot13 in ipairs(slot2) do
					slot18 = "<color=%s>"

					for slot18 = 0, slot8:GetComponentsInChildren(gohelper.Type_TextMesh).Length - 1 do
						if slot14[slot18].gameObject.name == "txt_" .. slot12 then
							slot14[slot18].text = string.gsub(string.gsub(slot13, "%{", string.format(slot18, "#ff906a")), "%}", "</color>")
						end
					end
				end
			end
		end
	end
end

function slot0.onClose(slot0)
	if slot0._btn_ani then
		ZProj.TweenHelper.KillById(slot0._btn_ani)
	end

	FightAudioMgr.instance:obscureBgm(false)
end

function slot0.onDestroyView(slot0)
	slot0._simageicon:UnLoadImage()
	slot0._simagebg:UnLoadImage()
end

return slot0

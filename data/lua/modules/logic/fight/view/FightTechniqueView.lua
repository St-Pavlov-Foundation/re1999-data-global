module("modules.logic.fight.view.FightTechniqueView", package.seeall)

local var_0_0 = class("FightTechniqueView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")
	arg_1_0._gocategorycontent = gohelper.findChild(arg_1_0.viewGO, "left/scroll_category/viewport/#go_categorycontent")
	arg_1_0._gostorecategoryitem = gohelper.findChild(arg_1_0.viewGO, "left/scroll_category/viewport/#go_categorycontent/#go_storecategoryitem")
	arg_1_0._gocenter = gohelper.findChild(arg_1_0.viewGO, "#go_center")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_center/#simage_icon")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")

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
	arg_5_0._simagebg:LoadImage(ResUrl.getTechniqueBg("banner_di"))
end

function var_0_0.onUpdateParam(arg_6_0)
	local var_6_0 = arg_6_0.viewParam and arg_6_0.viewParam.defaultShowId

	if var_6_0 then
		local var_6_1 = lua_fight_technique.configDict[var_6_0]

		if var_6_1 then
			local var_6_2 = var_6_1.mainTitleId
			local var_6_3 = tabletool.indexOf(arg_6_0.btn_data_list[var_6_2], var_6_1)

			if arg_6_0.cur_select_main_index == var_6_2 then
				arg_6_0.cur_select_sub_index = nil

				arg_6_0:_onSubBtnClick(var_6_3)
				arg_6_0:_btn_tween_open_end()
			else
				arg_6_0:_onBtnClick({
					index = var_6_2,
					subIndex = var_6_3
				})
			end
		end
	end
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.btn_data_list = {}

	local var_7_0 = arg_7_0.viewParam and arg_7_0.viewParam.isGMShowAll or false
	local var_7_1 = arg_7_0.viewParam and arg_7_0.viewParam.defaultShowId
	local var_7_2 = {}
	local var_7_3

	for iter_7_0, iter_7_1 in ipairs(lua_fight_technique.configList) do
		if iter_7_1.mainTitleId ~= 0 then
			if not var_7_2[iter_7_1.mainTitleId] then
				var_7_2[iter_7_1.mainTitleId] = {}
			end

			if arg_7_0:checkIsNeedShowTechnique(iter_7_1, var_7_0) then
				table.insert(var_7_2[iter_7_1.mainTitleId], iter_7_1)

				if var_7_1 == iter_7_1.id then
					var_7_3 = iter_7_1
				end
			end
		end
	end

	for iter_7_2, iter_7_3 in pairs(var_7_2) do
		table.sort(var_7_2[iter_7_2], var_0_0.sortSubTechniqueConfig)

		if #var_7_2[iter_7_2] > 0 then
			table.insert(arg_7_0.btn_data_list, var_7_2[iter_7_2])
		end
	end

	table.sort(arg_7_0.btn_data_list, var_0_0.sortTechniqueConfig)

	arg_7_0.btn_list = arg_7_0:getUserDataTb_()
	arg_7_0.sub_btn_height = {}
	arg_7_0.btn_sub_list = arg_7_0:getUserDataTb_()

	gohelper.CreateObjList(arg_7_0, arg_7_0._onBtnShow, arg_7_0.btn_data_list, arg_7_0._gocategorycontent, arg_7_0._gostorecategoryitem)

	if #arg_7_0.btn_data_list > 0 then
		local var_7_4 = 1
		local var_7_5 = 1

		if var_7_3 then
			var_7_4 = var_7_3.mainTitleId
			var_7_5 = tabletool.indexOf(arg_7_0.btn_data_list[var_7_4], var_7_3)

			arg_7_0:_onBtnClick({
				index = var_7_4,
				subIndex = var_7_5
			})
		else
			recthelper.setHeight(arg_7_0.btn_list[1].transform, 130)
			recthelper.setHeight(arg_7_0.btn_list[1].transform:Find("go_childcategory").transform, 0)

			arg_7_0.cur_select_main_index = var_7_4
			arg_7_0.cur_select_sub_index = nil

			arg_7_0:_detectBtnState()
			arg_7_0:_onSubBtnClick(var_7_5)
			gohelper.setActive(arg_7_0.btn_list[1].transform:Find("go_line").gameObject, false)
			arg_7_0:_btn_tween_open_end()

			arg_7_0.cur_select_main_index = nil
		end
	end

	FightAudioMgr.instance:obscureBgm(true)
end

function var_0_0.checkIsNeedShowTechnique(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 then
		local var_8_0 = true
		local var_8_1 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)
		local var_8_2 = true
		local var_8_3 = false

		if not string.nilorempty(arg_8_1.displayType) then
			var_8_2 = arg_8_0:checkCurEpisodeTypeIsMatch(arg_8_1.displayType)
		end

		if not string.nilorempty(arg_8_1.noDisplayType) then
			var_8_3 = arg_8_0:checkCurEpisodeTypeIsMatch(arg_8_1.noDisplayType)
		end

		local var_8_4 = var_8_2 and not var_8_3
		local var_8_5 = arg_8_2 or string.nilorempty(arg_8_1.condition) or FightViewTechniqueModel.instance:isUnlock(arg_8_1.id)

		return var_8_4 and var_8_5
	end
end

function var_0_0.checkCurEpisodeTypeIsMatch(arg_9_0, arg_9_1)
	local var_9_0 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)
	local var_9_1 = var_9_0 and var_9_0.type
	local var_9_2 = string.split(arg_9_1, "#")

	if var_9_2 then
		for iter_9_0, iter_9_1 in ipairs(var_9_2) do
			if tonumber(iter_9_1) == var_9_1 then
				return true
			end
		end
	end

	return false
end

function var_0_0._onBtnShow(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_1.transform
	local var_10_1 = gohelper.getClickWithAudio(var_10_0:Find("clickArea").gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	local var_10_2 = var_10_0:Find("go_unselected/txt_itemcn1"):GetComponent(gohelper.Type_TextMesh)
	local var_10_3 = var_10_0:Find("go_unselected/txt_itemen1"):GetComponent(gohelper.Type_TextMesh)
	local var_10_4 = var_10_0:Find("go_selected/txt_itemcn2"):GetComponent(gohelper.Type_TextMesh)
	local var_10_5 = var_10_0:Find("go_selected/txt_itemen2"):GetComponent(gohelper.Type_TextMesh)

	var_10_2.text = arg_10_2[1].mainTitle_cn
	var_10_3.text = arg_10_2[1].mainTitle_en
	var_10_4.text = arg_10_2[1].mainTitle_cn
	var_10_5.text = arg_10_2[1].mainTitle_en
	arg_10_0.sub_belong_index = arg_10_3
	arg_10_0.sub_btn_pos_y = -60

	gohelper.CreateObjList(arg_10_0, arg_10_0._onSubBtnShow, arg_10_2, var_10_0:Find("go_childcategory").gameObject, var_10_0:Find("go_childcategory/go_childitem").gameObject)

	arg_10_0.sub_btn_height[arg_10_3] = math.abs(arg_10_0.sub_btn_pos_y + 70)

	table.insert(arg_10_0.btn_list, arg_10_1)
	arg_10_0:removeClickCb(var_10_1)
	arg_10_0:addClickCb(var_10_1, arg_10_0._onBtnClick, arg_10_0, {
		index = arg_10_3
	})
end

function var_0_0._onBtnClick(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.index
	local var_11_1 = arg_11_1.subIndex or 1

	if arg_11_0.cur_select_main_index == var_11_0 then
		if arg_11_0._btn_ani then
			ZProj.TweenHelper.KillById(arg_11_0._btn_ani)
		end

		arg_11_0._btn_ani = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.3, arg_11_0._onBtnAniFrameCallback, arg_11_0._btn_tween_end, arg_11_0)

		return
	end

	if arg_11_0.cur_select_main_index then
		recthelper.setHeight(arg_11_0.btn_list[arg_11_0.cur_select_main_index].transform, 130)
		recthelper.setHeight(arg_11_0.btn_list[arg_11_0.cur_select_main_index].transform:Find("go_childcategory").transform, 0)
	end

	arg_11_0.cur_select_main_index = var_11_0
	arg_11_0.cur_select_sub_index = nil

	arg_11_0:_detectBtnState()
	arg_11_0:_onSubBtnClick(var_11_1)

	if arg_11_0._btn_ani then
		ZProj.TweenHelper.KillById(arg_11_0._btn_ani)
	end

	gohelper.setActive(arg_11_0.btn_list[arg_11_0.cur_select_main_index].transform:Find("go_line").gameObject, true)

	arg_11_0._btn_ani = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.3, arg_11_0._onBtnAniFrameCallback, arg_11_0._btn_tween_open_end, arg_11_0)
end

function var_0_0._onBtnAniFrameCallback(arg_12_0, arg_12_1)
	recthelper.setHeight(arg_12_0.btn_list[arg_12_0.cur_select_main_index].transform, 130 + arg_12_0.sub_btn_height[arg_12_0.cur_select_main_index] * arg_12_1)
	recthelper.setHeight(arg_12_0.btn_list[arg_12_0.cur_select_main_index].transform:Find("go_childcategory").transform, arg_12_0.sub_btn_height[arg_12_0.cur_select_main_index] * arg_12_1)
end

function var_0_0.scrollItemIsVisible(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1.transform:InverseTransformPoint(arg_13_2.transform.position).y + recthelper.getHeight(arg_13_2.transform) / 2

	if var_13_0 >= 65 or var_13_0 <= -785 then
		recthelper.setAnchorY(arg_13_0._gocategorycontent.transform, 130 * (arg_13_0.cur_select_main_index - 1) - 60)
	end
end

function var_0_0._btn_tween_open_end(arg_14_0)
	arg_14_0:scrollItemIsVisible(gohelper.findChild(arg_14_0.viewGO, "left/scroll_category"), arg_14_0.btn_list[arg_14_0.cur_select_main_index])
end

function var_0_0._btn_tween_end(arg_15_0)
	gohelper.setActive(arg_15_0.btn_list[arg_15_0.cur_select_main_index].transform:Find("go_line").gameObject, false)

	arg_15_0.cur_select_main_index = nil
end

function var_0_0._detectBtnState(arg_16_0)
	if arg_16_0.btn_list then
		for iter_16_0, iter_16_1 in ipairs(arg_16_0.btn_list) do
			local var_16_0 = iter_16_1 == arg_16_0.btn_list[arg_16_0.cur_select_main_index]
			local var_16_1 = iter_16_1.transform

			gohelper.setActive(var_16_1:Find("go_line").gameObject, var_16_0)
			gohelper.setActive(var_16_1:Find("go_unselected").gameObject, not var_16_0)
			gohelper.setActive(var_16_1:Find("go_selected").gameObject, var_16_0)
			gohelper.setActive(var_16_1:Find("go_childcategory").gameObject, var_16_0)
		end
	end
end

function var_0_0._onSubBtnShow(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_1.transform

	recthelper.setAnchorY(var_17_0, arg_17_0.sub_btn_pos_y)

	arg_17_0.sub_btn_pos_y = arg_17_0.sub_btn_pos_y - 110

	local var_17_1 = gohelper.getClickWithAudio(var_17_0:Find("clickArea").gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	local var_17_2 = var_17_0:Find("go_unselected/txt_itemcn1"):GetComponent(gohelper.Type_TextMesh)
	local var_17_3 = var_17_0:Find("go_unselected/txt_itemen1"):GetComponent(gohelper.Type_TextMesh)
	local var_17_4 = var_17_0:Find("go_selected/txt_itemcn2"):GetComponent(gohelper.Type_TextMesh)
	local var_17_5 = var_17_0:Find("go_selected/txt_itemen2"):GetComponent(gohelper.Type_TextMesh)

	var_17_2.text = arg_17_2.title_cn
	var_17_3.text = arg_17_2.title_en
	var_17_4.text = arg_17_2.title_cn
	var_17_5.text = arg_17_2.title_en

	if not arg_17_0.btn_sub_list[arg_17_0.sub_belong_index] then
		arg_17_0.btn_sub_list[arg_17_0.sub_belong_index] = {}
	end

	table.insert(arg_17_0.btn_sub_list[arg_17_0.sub_belong_index], arg_17_1)
	arg_17_0:removeClickCb(var_17_1)
	arg_17_0:addClickCb(var_17_1, arg_17_0._onSubBtnClick, arg_17_0, arg_17_3)
end

function var_0_0._onSubBtnClick(arg_18_0, arg_18_1)
	if arg_18_0.cur_select_sub_index == arg_18_1 then
		return
	end

	arg_18_0.cur_select_sub_index = arg_18_1
	arg_18_0.cur_select_data = arg_18_0.btn_data_list[arg_18_0.cur_select_main_index][arg_18_1]

	arg_18_0:_detectSubBtnState()
	arg_18_0:_refreshContentData()
end

function var_0_0._detectSubBtnState(arg_19_0)
	if arg_19_0.btn_sub_list then
		for iter_19_0, iter_19_1 in ipairs(arg_19_0.btn_sub_list[arg_19_0.cur_select_main_index]) do
			local var_19_0 = iter_19_1 == arg_19_0.btn_sub_list[arg_19_0.cur_select_main_index][arg_19_0.cur_select_sub_index]
			local var_19_1 = iter_19_1.transform

			gohelper.setActive(var_19_1:Find("go_unselected").gameObject, not var_19_0)
			gohelper.setActive(var_19_1:Find("go_selected").gameObject, var_19_0)
		end
	end
end

function var_0_0.sortTechniqueConfig(arg_20_0, arg_20_1)
	return arg_20_0[1].mainTitleId < arg_20_1[1].mainTitleId
end

function var_0_0.sortSubTechniqueConfig(arg_21_0, arg_21_1)
	return arg_21_0.subTitleId < arg_21_1.subTitleId
end

function var_0_0._refreshContentData(arg_22_0)
	if not (arg_22_0.viewParam and arg_22_0.viewParam.isGMShowAll or false) then
		FightViewTechniqueModel.instance:readTechnique(arg_22_0.cur_select_data.id)
	end

	arg_22_0._simageicon:LoadImage(ResUrl.getTechniqueLangIcon(arg_22_0.cur_select_data.picture1))

	local var_22_0 = string.split(arg_22_0.cur_select_data.content1, "|")

	for iter_22_0, iter_22_1 in pairs(lua_fight_technique.configDict) do
		local var_22_1 = gohelper.findChild(arg_22_0.viewGO, "#go_center/content/" .. iter_22_1.id)

		if var_22_1 then
			gohelper.setActive(var_22_1, iter_22_1.id == arg_22_0.cur_select_data.id)

			if arg_22_0.cur_select_data.id == iter_22_1.id then
				for iter_22_2, iter_22_3 in ipairs(var_22_0) do
					iter_22_3 = string.gsub(iter_22_3, "%{", string.format("<color=%s>", "#ff906a"))
					iter_22_3 = string.gsub(iter_22_3, "%}", "</color>")

					local var_22_2 = var_22_1:GetComponentsInChildren(gohelper.Type_TextMesh)

					for iter_22_4 = 0, var_22_2.Length - 1 do
						if var_22_2[iter_22_4].gameObject.name == "txt_" .. iter_22_2 then
							var_22_2[iter_22_4].text = iter_22_3
						end
					end
				end
			end
		end
	end
end

function var_0_0.onClose(arg_23_0)
	if arg_23_0._btn_ani then
		ZProj.TweenHelper.KillById(arg_23_0._btn_ani)
	end

	FightAudioMgr.instance:obscureBgm(false)
end

function var_0_0.onDestroyView(arg_24_0)
	arg_24_0._simageicon:UnLoadImage()
	arg_24_0._simagebg:UnLoadImage()
end

return var_0_0

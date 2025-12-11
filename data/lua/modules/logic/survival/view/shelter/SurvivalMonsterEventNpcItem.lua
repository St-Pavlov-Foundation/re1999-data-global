module("modules.logic.survival.view.shelter.SurvivalMonsterEventNpcItem", package.seeall)

local var_0_0 = class("SurvivalMonsterEventNpcItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goGrid = gohelper.findChild(arg_1_0.viewGO, "Grid")
	arg_1_0.goSmallItem = gohelper.findChild(arg_1_0.viewGO, "#go_SmallItem")

	gohelper.setActive(arg_1_0.goSmallItem, false)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

local var_0_1 = 0.6

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.itemList = arg_4_0:getUserDataTb_()
end

function var_0_0.onClickGridItem(arg_5_0, arg_5_1)
	if not arg_5_1.data then
		return
	end

	local var_5_0 = arg_5_1.data:getShelterNpcStatus()

	if var_5_0 == SurvivalEnum.ShelterNpcStatus.InDestoryBuild then
		GameFacade.showToast(ToastEnum.SurvivalBossSelectNpcBuildDestroy)

		return
	end

	if var_5_0 == SurvivalEnum.ShelterNpcStatus.NotInBuild or var_5_0 == SurvivalEnum.ShelterNpcStatus.OutSide then
		return
	end

	local var_5_1 = arg_5_1.data.id

	if SurvivalShelterNpcMonsterListModel.instance:isSelectNpc(var_5_1) then
		if SurvivalShelterNpcMonsterListModel.instance:cancelSelect(var_5_1) then
			arg_5_0._view.viewContainer:refreshView()
		end
	else
		if not SurvivalShelterNpcMonsterListModel.instance:canSelect() then
			GameFacade.showToast(ToastEnum.SurvivalBossSelectNpcFull)

			return
		end

		if SurvivalShelterNpcMonsterListModel.instance:setSelectNpcId(var_5_1) then
			arg_5_0._view.viewContainer:refreshView()
		end
	end
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0.mo = arg_6_1

	if not arg_6_1 then
		return
	end

	local var_6_0 = arg_6_1.dataList

	for iter_6_0 = 1, math.max(#var_6_0, #arg_6_0.itemList) do
		local var_6_1 = arg_6_0:getGridItem(iter_6_0)

		arg_6_0:refreshGridItem(var_6_1, var_6_0[iter_6_0])
	end
end

local var_0_2 = ZProj.UIEffectsCollection

function var_0_0.getGridItem(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.itemList[arg_7_1]

	if not var_7_0 then
		var_7_0 = arg_7_0:getUserDataTb_()
		var_7_0.index = arg_7_1
		var_7_0.go = gohelper.clone(arg_7_0.goSmallItem, arg_7_0.goGrid, tostring(arg_7_1))
		var_7_0.imgChess = gohelper.findChildSingleImage(var_7_0.go, "#image_Chess")
		var_7_0.txtName = gohelper.findChildTextMesh(var_7_0.go, "#txt_PartnerName")
		var_7_0.goSelect = gohelper.findChild(var_7_0.go, "#go_Selected")
		var_7_0.goRecommend = gohelper.findChild(var_7_0.go, "#go_recommend")
		var_7_0.goTagItem = gohelper.findChild(var_7_0.go, "#scroll_tag/viewport/content/#go_tagitem")
		var_7_0.goEffect = var_0_2.Get(var_7_0.go)

		gohelper.setActive(var_7_0.goTagItem, false)

		var_7_0.btn = gohelper.findButtonWithAudio(var_7_0.go)

		var_7_0.btn:AddClickListener(arg_7_0.onClickGridItem, arg_7_0, var_7_0)

		var_7_0.allTags = arg_7_0:getUserDataTb_()
		arg_7_0.itemList[arg_7_1] = var_7_0
	end

	return var_7_0
end

function var_0_0.refreshGridItem(arg_8_0, arg_8_1, arg_8_2)
	arg_8_1.data = arg_8_2

	if not arg_8_2 then
		gohelper.setActive(arg_8_1.go, false)

		return
	end

	gohelper.setActive(arg_8_1.go, true)
	gohelper.setActive(arg_8_1.goSelect, SurvivalShelterNpcMonsterListModel.instance:isSelectNpc(arg_8_2.id))

	local var_8_0 = SurvivalShelterMonsterModel.instance:calRecommendNum(arg_8_2.id)

	gohelper.setActive(arg_8_1.goRecommend, var_8_0 > 0)

	arg_8_1.txtName.text = arg_8_2.co.name

	SurvivalUnitIconHelper.instance:setNpcIcon(arg_8_1.imgChess, arg_8_2.co.headIcon)

	if arg_8_1.goEffect then
		local var_8_1 = arg_8_1.data:getShelterNpcStatus()
		local var_8_2 = var_8_1 == SurvivalEnum.ShelterNpcStatus.NotInBuild or var_8_1 == SurvivalEnum.ShelterNpcStatus.OutSide

		arg_8_1.goEffect:SetGray(var_8_2)
	end

	if arg_8_1.allTags then
		for iter_8_0 = 1, #arg_8_1.allTags do
			gohelper.destroy(arg_8_1.allTags[iter_8_0])
		end

		arg_8_1.allTags = {}
	end

	local var_8_3, var_8_4 = SurvivalConfig.instance:getNpcConfigTag(arg_8_2.id)

	for iter_8_1 = 1, #var_8_4 do
		local var_8_5 = var_8_4[iter_8_1]

		if var_8_5 then
			local var_8_6 = lua_survival_tag.configDict[var_8_5]

			if var_8_6 ~= nil then
				local var_8_7 = gohelper.cloneInPlace(arg_8_1.goTagItem, var_8_5)
				local var_8_8 = gohelper.findChildImage(var_8_7, "#image_Type")
				local var_8_9 = SurvivalConst.ShelterTagColor[var_8_6.tagType]

				if var_8_9 then
					local var_8_10 = GameUtil.parseColor(var_8_9)

					var_8_10.a = SurvivalShelterMonsterModel.instance:isNeedNpcTag(var_8_5) and 1 or var_0_1
					var_8_8.color = var_8_10
				end

				gohelper.findChildText(var_8_7, "#txt_Type").text = var_8_6.name

				gohelper.setActive(var_8_7, true)
				table.insert(arg_8_1.allTags, var_8_7)
			else
				logError("SurvivalMonsterEventNpcItem:refreshGridItem tag config is nil, tagId = " .. tostring(var_8_5) .. " npcId = " .. tostring(arg_8_2.id))
			end
		end
	end
end

function var_0_0.onDestroyView(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.itemList) do
		iter_9_1.btn:RemoveClickListener()
	end
end

return var_0_0

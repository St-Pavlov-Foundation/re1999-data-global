module("modules.logic.room.view.manufacture.RoomManufactureCritterDetail", package.seeall)

local var_0_0 = class("RoomManufactureCritterDetail", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocritter = gohelper.findChild(arg_1_0.viewGO, "go_critterLayer/#go_critter")
	arg_1_0._txtcritterName = gohelper.findChildText(arg_1_0.viewGO, "go_critterLayer/#txt_critterName")
	arg_1_0._gomood = gohelper.findChild(arg_1_0.viewGO, "go_critterLayer/#go_mood")
	arg_1_0._gohasMood = gohelper.findChild(arg_1_0.viewGO, "go_critterLayer/#go_mood/#go_hasMood")
	arg_1_0._simagemood = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_critterLayer/#go_mood/#go_hasMood/#simage_mood")
	arg_1_0._simageprogress = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_critterLayer/#go_mood/#go_hasMood/#simage_progress")
	arg_1_0._txtmood = gohelper.findChildText(arg_1_0.viewGO, "go_critterLayer/#go_mood/#go_hasMood/#txt_mood")
	arg_1_0._gonoMood = gohelper.findChild(arg_1_0.viewGO, "go_critterLayer/#go_mood/#go_noMood")
	arg_1_0._goskillItem = gohelper.findChild(arg_1_0.viewGO, "#go_skillItem")
	arg_1_0._txtskillname = gohelper.findChildText(arg_1_0.viewGO, "#go_skillItem/title/#txt_skillname")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_skillItem/title/#txt_skillname/#image_icon")
	arg_1_0._txtskilldec = gohelper.findChildText(arg_1_0.viewGO, "#go_skillItem/#txt_skilldec")
	arg_1_0._gobaseitem = gohelper.findChild(arg_1_0.viewGO, "#go_baseitem")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_baseitem/#txt_name")
	arg_1_0._txtratio = gohelper.findChildText(arg_1_0.viewGO, "#go_baseitem/#txt_ratio")
	arg_1_0._gobaseLayer = gohelper.findChild(arg_1_0.viewGO, "#go_baseLayer")
	arg_1_0._goskill = gohelper.findChild(arg_1_0.viewGO, "#go_skill")
	arg_1_0._goskillActive = gohelper.findChild(arg_1_0.viewGO, "#go_skillActive")
	arg_1_0._btnyulan = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_skillActive/#btn_yulan")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnyulan:AddClickListener(arg_2_0._btnyulanOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnyulan:RemoveClickListener()
end

function var_0_0._btnyulanOnClick(arg_4_0)
	arg_4_0:_setShowInvalidSkill(arg_4_0._isShowInvalidSkill == false)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._godark = gohelper.findChild(arg_5_0.viewGO, "#go_skillActive/#btn_yulan/dark")
	arg_5_0._golight = gohelper.findChild(arg_5_0.viewGO, "#go_skillActive/#btn_yulan/light")
	arg_5_0._imageprogress = gohelper.findChildImage(arg_5_0.viewGO, "go_critterLayer/#go_mood/#go_hasMood/#simage_progress")
	arg_5_0._Type_Canvas_Group = typeof(UnityEngine.CanvasGroup)
	arg_5_0._skillTBList = {}
	arg_5_0._skillTBInvalidList = {}

	gohelper.setActive(arg_5_0._gobaseitem, false)
	gohelper.setActive(arg_5_0._goskillItem, false)

	local var_5_0 = ManufactureConfig.instance:getManufactureConst(RoomManufactureEnum.ConstId.CritterMaxMood)

	arg_5_0._maxMood = tonumber(var_5_0) or 0
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._critterMO = arg_8_1
	arg_8_0._tagsCfgList = {}
	arg_8_0._tagsCfgInvalidList = {}
	arg_8_0._preViewAttrInfo = {}
	arg_8_0._buildingId = arg_8_0:getBuildingId()
	arg_8_0._previewAttrInfo = nil

	if arg_8_0._critterMO and arg_8_0._critterMO.skillInfo then
		local var_8_0 = ManufactureCritterListModel.instance:getPreviewAttrInfo(arg_8_0._critterMO:getId(), arg_8_0._buildingId, false)
		local var_8_1 = arg_8_0._critterMO.skillInfo.tags or {}

		for iter_8_0 = 1, #var_8_1 do
			local var_8_2 = CritterConfig.instance:getCritterTagCfg(var_8_1[iter_8_0])

			if var_8_2 then
				if var_8_0 and var_8_0.skillTags and tabletool.indexOf(var_8_0.skillTags, var_8_2.id) then
					table.insert(arg_8_0._tagsCfgList, var_8_2)
				else
					table.insert(arg_8_0._tagsCfgInvalidList, var_8_2)
				end
			end
		end
	end

	arg_8_0:_refreshCritterUI()
	arg_8_0:_refreshAttr()
	arg_8_0:_refreshTagTB(arg_8_0._tagsCfgList, arg_8_0._skillTBList, arg_8_0._goskill)
	arg_8_0:_refreshTagTB(arg_8_0._tagsCfgInvalidList, arg_8_0._skillTBInvalidList, arg_8_0._goskillActive, 0.5)
	arg_8_0:_setShowInvalidSkill(false)
	gohelper.setActive(arg_8_0._btnyulan, #arg_8_0._tagsCfgInvalidList > 0)
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	for iter_10_0 = 1, #arg_10_0._attrItems do
		arg_10_0._attrItems[iter_10_0]:onDestroy()
	end
end

function var_0_0.getBuildingId(arg_11_0)
	local var_11_0

	if arg_11_0._critterMO then
		local var_11_1, var_11_2 = arg_11_0._critterMO:getWorkBuildingInfo()
		local var_11_3 = RoomMapBuildingModel.instance:getBuildingMOById(var_11_1)

		if var_11_3 then
			var_11_0 = var_11_3.buildingId
		end
	end

	return var_11_0
end

function var_0_0._createTagTB(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getUserDataTb_()

	var_12_0.go = arg_12_1
	var_12_0._txtskillname = gohelper.findChildText(arg_12_1, "title/#txt_skillname")
	var_12_0._imageicon = gohelper.findChildImage(arg_12_1, "title/#txt_skillname/#image_icon")
	var_12_0._txtskilldec = gohelper.findChildText(arg_12_1, "#txt_skilldec")

	return var_12_0
end

function var_0_0._refreshTagTB(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = 0
	local var_13_1 = arg_13_2

	if not var_13_1 then
		return
	end

	if arg_13_1 and #arg_13_1 > 0 then
		for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
			var_13_0 = var_13_0 + 1

			local var_13_2 = var_13_1[iter_13_0]

			if not var_13_2 then
				local var_13_3 = gohelper.clone(arg_13_0._goskillItem, arg_13_3)

				var_13_2 = arg_13_0:_createTagTB(var_13_3)

				table.insert(var_13_1, var_13_2)

				if arg_13_4 then
					var_13_3:GetComponent(arg_13_0._Type_Canvas_Group).alpha = arg_13_4
				end
			end

			var_13_2._txtskillname.text = iter_13_1.name
			var_13_2._txtskilldec.text = iter_13_1.desc

			UISpriteSetMgr.instance:setCritterSprite(var_13_2._imageicon, iter_13_1.skillIcon)
		end
	end

	for iter_13_2 = 1, #var_13_1 do
		gohelper.setActive(var_13_1[iter_13_2].go, iter_13_2 <= var_13_0)
	end
end

function var_0_0._setTagTBActive(arg_14_0, arg_14_1, arg_14_2)
	for iter_14_0 = 1, #arg_14_1 do
		gohelper.setActive(arg_14_1[iter_14_0].go, iter_14_0 <= arg_14_2)
	end
end

function var_0_0._setShowInvalidSkill(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1 and true or false

	arg_15_0._isShowInvalidSkill = var_15_0

	gohelper.setActive(arg_15_0._godark, var_15_0)
	gohelper.setActive(arg_15_0._golight, not var_15_0)

	local var_15_1 = var_15_0 and #arg_15_0._skillTBInvalidList or 0

	arg_15_0:_setTagTBActive(arg_15_0._skillTBInvalidList, var_15_1)
end

function var_0_0._refreshAttr(arg_16_0)
	if not arg_16_0._critterMO then
		return
	end

	local var_16_0 = arg_16_0._critterMO:getAttributeInfos()

	if not arg_16_0._attrItems then
		arg_16_0._attrItems = arg_16_0:getUserDataTb_()
	end

	local var_16_1 = 1

	if var_16_0 then
		local var_16_2 = arg_16_0._critterMO.id

		for iter_16_0, iter_16_1 in pairs(var_16_0) do
			local var_16_3 = arg_16_0._attrItems[var_16_1]

			if not var_16_3 then
				local var_16_4 = gohelper.clone(arg_16_0._gobaseitem, arg_16_0._gobaseLayer)

				var_16_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_16_4, RoomCritterDetailAttrItem)

				table.insert(arg_16_0._attrItems, var_16_3)
			end

			local var_16_5 = CritterHelper.getPreViewAttrValue(iter_16_1.attributeId, var_16_2, arg_16_0._buildingId, false)
			local var_16_6 = CritterHelper.formatAttrValue(iter_16_1.attributeId, var_16_5)

			var_16_3:onRefreshMo(iter_16_1, var_16_1, var_16_6, var_16_6, iter_16_1:getName())

			var_16_1 = var_16_1 + 1
		end
	end

	for iter_16_2 = 1, #arg_16_0._attrItems do
		gohelper.setActive(arg_16_0._attrItems[iter_16_2].viewGO, iter_16_2 < var_16_1)
	end
end

function var_0_0._refreshCritterUI(arg_17_0)
	if not arg_17_0._critterMO then
		return
	end

	if not arg_17_0.critterIcon then
		arg_17_0.critterIcon = IconMgr.instance:getCommonCritterIcon(arg_17_0._gocritter)
	end

	arg_17_0.critterIcon:setMOValue(arg_17_0._critterMO:getId(), arg_17_0._critterMO:getDefineId())

	arg_17_0._txtcritterName.text = arg_17_0._critterMO:getName()

	local var_17_0 = arg_17_0._critterMO:isNoMood()

	gohelper.setActive(arg_17_0._gonoMood, var_17_0)
	gohelper.setActive(arg_17_0._gohasMood, not var_17_0)

	if not var_17_0 then
		local var_17_1 = arg_17_0._critterMO:getMoodValue()

		arg_17_0._txtmood.text = var_17_1

		local var_17_2 = 1

		if arg_17_0._maxMood ~= 0 then
			var_17_2 = var_17_1 / arg_17_0._maxMood
		end

		arg_17_0._imageprogress.fillAmount = var_17_2
	end
end

var_0_0.prefabPath = "ui/viewres/room/manufacture/roommanufacturecritterdetail.prefab"

return var_0_0

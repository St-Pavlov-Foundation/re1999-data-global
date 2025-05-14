module("modules.logic.room.view.critter.detail.RoomCritterDetailMaturityView", package.seeall)

local var_0_0 = class("RoomCritterDetailMaturityView", RoomCritterDetailView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._gomaturity = gohelper.findChild(arg_1_0.viewGO, "#go_maturity")
	arg_1_0._txtbuilding = gohelper.findChildText(arg_1_0.viewGO, "#go_maturity/Left/building/bg/#txt_building")
	arg_1_0._imagebuildingicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_maturity/Left/building/#image_buildingicon")
	arg_1_0._godetail = gohelper.findChild(arg_1_0.viewGO, "#go_maturity/Left/#go_detail")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_maturity/Left/#go_detail/#txt_name")
	arg_1_0._imagelock = gohelper.findChildImage(arg_1_0.viewGO, "#go_maturity/Left/#go_detail/#txt_name/#image_lock")
	arg_1_0._btnnameedit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_maturity/Left/#go_detail/#txt_name/#btn_nameedit")
	arg_1_0._txttag1 = gohelper.findChildText(arg_1_0.viewGO, "#go_maturity/Left/#go_detail/tag/#txt_tag1")
	arg_1_0._txttag2 = gohelper.findChildText(arg_1_0.viewGO, "#go_maturity/Left/#go_detail/tag/#txt_tag2")
	arg_1_0._imagesort = gohelper.findChildImage(arg_1_0.viewGO, "#go_maturity/Left/#go_detail/#image_sort")
	arg_1_0._txtsort = gohelper.findChildText(arg_1_0.viewGO, "#go_maturity/Left/#go_detail/#image_sort/#txt_sort")
	arg_1_0._scrolldes = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_maturity/Left/#go_detail/#scroll_des")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_maturity/Left/#go_detail/#scroll_des/viewport/content/#txt_Desc")
	arg_1_0._btnreport = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_maturity/Left/#btn_report")
	arg_1_0._gocritterlive2d = gohelper.findChild(arg_1_0.viewGO, "#go_maturity/Middle/#go_critterlive2d")
	arg_1_0._scrollbase = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_maturity/Right/base/#scroll_base")
	arg_1_0._gobaseitem = gohelper.findChild(arg_1_0.viewGO, "#go_maturity/Right/base/#scroll_base/viewport/content/#go_baseitem")
	arg_1_0._scrolltipbase = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_maturity/Right/base/basetips/#scroll_base")
	arg_1_0._gobasetipsitem = gohelper.findChild(arg_1_0.viewGO, "#go_maturity/Right/base/basetips/#scroll_base/viewport/content/#go_basetipsitem")
	arg_1_0._scrollskill = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_maturity/Right/skill/#scroll_skill")
	arg_1_0._goskillItem = gohelper.findChild(arg_1_0.viewGO, "#go_maturity/Right/skill/#scroll_skill/viewport/content/#go_skillItem")
	arg_1_0._scrollnormalskill = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_maturity/Right/normalskill/#scroll_normalskill")
	arg_1_0._gonormalskillitem = gohelper.findChild(arg_1_0.viewGO, "#go_maturity/Right/normalskill/#scroll_normalskill/viewport/content/#go_normalskillitem")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._gostar = gohelper.findChild(arg_1_0.viewGO, "#go_maturity/Left/#go_detail/starList")
	arg_1_0._gotipbase = gohelper.findChild(arg_1_0.viewGO, "#go_maturity/Right/base/basetips")
	arg_1_0._gobuilding = gohelper.findChild(arg_1_0.viewGO, "#go_maturity/Left/building")
	arg_1_0._goLock = gohelper.findChild(arg_1_0.viewGO, "#go_maturity/Left/#go_detail/#txt_name/#image_lock")
	arg_1_0._gonormalskill = gohelper.findChild(arg_1_0.viewGO, "#go_maturity/Right/normalskill")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0._btnreport:AddClickListener(arg_2_0._btnreportOnClick, arg_2_0)
	arg_2_0._btnnameedit:AddClickListener(arg_2_0._btnnameeditOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0._btnreport:RemoveClickListener()
	arg_3_0._btnnameedit:RemoveClickListener()
end

function var_0_0._btnreportOnClick(arg_4_0)
	RoomCritterController.instance:openTrainReporView(arg_4_0._critterMo:getId(), arg_4_0._critterMo.trainHeroId, arg_4_0._critterMo.totalFinishCount)
end

function var_0_0._btnnameeditOnClick(arg_5_0)
	if arg_5_0._critterMo then
		RoomCritterController.instance:openRenameView(arg_5_0._critterMo:getId())
	end
end

function var_0_0._editableInitView(arg_6_0)
	var_0_0.super._editableInitView(arg_6_0)
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:addEventCb(CritterController.instance, CritterEvent.CritterRenameReply, arg_7_0._onCritterRenameReply, arg_7_0)
	var_0_0.super.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mj_open)
end

function var_0_0._onCritterRenameReply(arg_8_0, arg_8_1)
	if arg_8_0._critterMo and arg_8_0._critterMo.id == arg_8_1 then
		arg_8_0:showInfo()
	end
end

function var_0_0.onRefresh(arg_9_0)
	arg_9_0._critterMo = arg_9_0.viewParam.critterMo

	var_0_0.super.onRefresh(arg_9_0)
	arg_9_0:refreshWordInfo()
	arg_9_0:refreshTrainInfo()
end

function var_0_0.getAttrRatio(arg_10_0, arg_10_1, arg_10_2)
	return arg_10_2:getValueNum()
end

function var_0_0.refreshWordInfo(arg_11_0)
	if not arg_11_0._critterMo then
		return
	end

	local var_11_0
	local var_11_1 = arg_11_0._critterMo:getId()
	local var_11_2 = false
	local var_11_3 = ManufactureModel.instance:getCritterWorkingBuilding(var_11_1) or ManufactureModel.instance:getCritterRestingBuilding(var_11_1)
	local var_11_4

	if var_11_3 then
		local var_11_5 = RoomMapBuildingModel.instance:getBuildingMOById(var_11_3)

		if var_11_5 then
			var_11_4 = ManufactureConfig.instance:getManufactureBuildingIcon(var_11_5.buildingId)
			var_11_0 = var_11_5.config.useDesc
			var_11_2 = true
		end
	else
		local var_11_6 = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(var_11_1)

		if var_11_6 then
			local var_11_7 = var_11_6.buildingId
			local var_11_8 = var_11_6.buildingSkinId
			local var_11_9 = RoomTransportHelper.getVehicleCfgByBuildingId(var_11_7, var_11_8)

			var_11_4 = var_11_9 and var_11_9.buildIcon

			local var_11_10 = RoomTransportHelper.fromTo2SiteType(var_11_6.fromType, var_11_6.toType)

			var_11_0 = luaLang(RoomBuildingEnum.BuildingTypeSiteLangKey[var_11_10])
			var_11_2 = true
		end
	end

	if var_11_2 then
		local var_11_11 = luaLang("room_critter_working_in")

		arg_11_0._txtbuilding.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_11_11, var_11_0)

		UISpriteSetMgr.instance:setRoomSprite(arg_11_0._imagebuildingicon, var_11_4)
	end

	gohelper.setActive(arg_11_0._gobuilding, var_11_2)
end

function var_0_0.showSkill(arg_12_0)
	var_0_0.super.showSkill(arg_12_0)

	if not arg_12_0._critterMo then
		return
	end

	local var_12_0 = arg_12_0._critterMo:getSkillInfo()

	if var_12_0 then
		gohelper.setActive(arg_12_0._gonormalskill.gameObject, true)

		local var_12_1 = 1

		for iter_12_0, iter_12_1 in pairs(var_12_0) do
			local var_12_2 = CritterConfig.instance:getCritterTagCfg(iter_12_1)

			if var_12_2 and var_12_2.type ~= RoomCritterDetailView._exclusiveSkill then
				arg_12_0:getNormalSkillItem(var_12_1):onRefreshMo(var_12_2)

				var_12_1 = var_12_1 + 1
			end
		end

		if arg_12_0._normalSkillItems then
			for iter_12_2 = 1, #arg_12_0._normalSkillItems do
				local var_12_3 = arg_12_0._normalSkillItems[iter_12_2]

				gohelper.setActive(var_12_3.viewGO, iter_12_2 < var_12_1)
			end
		end
	else
		gohelper.setActive(arg_12_0._gonormalskill.gameObject, false)
	end
end

function var_0_0.refreshTrainInfo(arg_13_0)
	gohelper.setActive(arg_13_0._btnreport.gameObject, arg_13_0:_isShowReport())
end

function var_0_0._isShowReport(arg_14_0)
	if arg_14_0._critterMo and arg_14_0._critterMo:isMaturity() and arg_14_0._critterMo.trainHeroId and tonumber(arg_14_0._critterMo.trainHeroId) ~= 0 then
		return true
	end

	return false
end

function var_0_0.getNormalSkillItem(arg_15_0, arg_15_1)
	if not arg_15_0._normalSkillItems then
		arg_15_0._normalSkillItems = arg_15_0:getUserDataTb_()
	end

	local var_15_0 = arg_15_0._normalSkillItems[arg_15_1]

	if not var_15_0 then
		local var_15_1 = gohelper.cloneInPlace(arg_15_0._gonormalskillitem)

		var_15_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_1, RoomCritterDetailSkillItem)
		arg_15_0._normalSkillItems[arg_15_1] = var_15_0
	end

	return var_15_0
end

return var_0_0

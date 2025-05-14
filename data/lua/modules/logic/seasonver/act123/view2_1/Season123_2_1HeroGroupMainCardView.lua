module("modules.logic.seasonver.act123.view2_1.Season123_2_1HeroGroupMainCardView", package.seeall)

local var_0_0 = class("Season123_2_1HeroGroupMainCardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagerole = gohelper.findChildSingleImage(arg_1_0.viewGO, "herogroupcontain/#simage_role")

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

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagerole:LoadImage(ResUrl.getSeasonIcon("img_vertin.png"))

	arg_4_0._supercardItems = {}
	arg_4_0._supercardGroups = {}

	for iter_4_0 = 1, Activity123Enum.MainCardNum do
		local var_4_0 = arg_4_0:getUserDataTb_()

		var_4_0.golight = gohelper.findChild(arg_4_0.viewGO, string.format("herogroupcontain/#go_supercard%s/light", iter_4_0))
		var_4_0.goempty = gohelper.findChild(arg_4_0.viewGO, string.format("herogroupcontain/#go_supercard%s/#go_supercardempty", iter_4_0))
		var_4_0.gopos = gohelper.findChild(arg_4_0.viewGO, string.format("herogroupcontain/#go_supercard%s/#go_supercardpos", iter_4_0))
		var_4_0.btnclick = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, string.format("herogroupcontain/#go_supercard%s/#btn_supercardclick", iter_4_0))

		var_4_0.btnclick:AddClickListener(arg_4_0._btnseasonsupercardOnClick, arg_4_0, iter_4_0)

		arg_4_0._supercardGroups[iter_4_0] = var_4_0
	end
end

function var_0_0.onDestroyView(arg_5_0)
	arg_5_0._simagerole:UnLoadImage()

	if arg_5_0._supercardGroups then
		for iter_5_0, iter_5_1 in pairs(arg_5_0._supercardGroups) do
			iter_5_1.btnclick:RemoveClickListener()
		end

		arg_5_0._supercardGroups = nil
	end

	if arg_5_0._supercardItems then
		for iter_5_2, iter_5_3 in pairs(arg_5_0._supercardItems) do
			iter_5_3:destroy()
		end

		arg_5_0._supercardItems = nil
	end
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_6_0.refreshMainCards, arg_6_0)
	arg_6_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_6_0.refreshMainCards, arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.HeroGroupIndexChanged, arg_6_0.refreshMainCards, arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.RecordRspMainCardRefresh, arg_6_0.refreshMainCards, arg_6_0)
	arg_6_0:refreshMainCards()
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.refreshMainCards(arg_8_0)
	for iter_8_0 = 1, Activity123Enum.MainCardNum do
		arg_8_0:_refreshMainCard(iter_8_0)
	end
end

function var_0_0._refreshMainCard(arg_9_0, arg_9_1)
	local var_9_0 = HeroGroupModel.instance:getCurGroupMO()
	local var_9_1 = Season123HeroGroupModel.instance:getMainPosEquipId(arg_9_1)
	local var_9_2 = arg_9_0._supercardGroups[arg_9_1]
	local var_9_3 = arg_9_0._supercardItems[arg_9_1]
	local var_9_4 = false

	if var_9_1 and var_9_1 ~= 0 then
		if not var_9_3 then
			var_9_3 = Season123_2_1CelebrityCardItem.New()

			var_9_3:init(var_9_2.gopos, var_9_1)

			arg_9_0._supercardItems[arg_9_1] = var_9_3
		else
			gohelper.setActive(var_9_3.go, true)
			var_9_3:reset(var_9_1)
		end

		var_9_4 = true
	elseif var_9_3 then
		gohelper.setActive(var_9_3.go, false)
	end

	gohelper.setActive(var_9_2.golight, var_9_4)

	local var_9_5 = Season123Model.instance:getActInfo(arg_9_0.viewParam.actId)

	if not var_9_5 then
		return
	end

	local var_9_6 = var_9_5.heroGroupSnapshotSubId
	local var_9_7 = Season123HeroGroupModel.instance:isEquipCardPosUnlock(arg_9_1, Season123EquipItemListModel.MainCharPos)

	gohelper.setActive(var_9_2.goempty, var_9_7)
	gohelper.setActive(var_9_2.btnclick, var_9_7)
end

function var_0_0._btnseasonsupercardOnClick(arg_10_0, arg_10_1)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	local var_10_0 = {
		actId = arg_10_0.viewParam.actId,
		stage = arg_10_0.viewParam.stage,
		slot = arg_10_1
	}

	if not Season123HeroGroupModel.instance:isEquipCardPosUnlock(var_10_0.slot, Season123EquipItemListModel.MainCharPos) then
		return
	end

	ViewMgr.instance:openView(Season123Controller.instance:getEquipHeroViewName(), var_10_0)
end

return var_0_0

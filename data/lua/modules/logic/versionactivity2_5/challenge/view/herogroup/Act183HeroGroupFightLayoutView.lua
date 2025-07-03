module("modules.logic.versionactivity2_5.challenge.view.herogroup.Act183HeroGroupFightLayoutView", package.seeall)

local var_0_0 = class("Act183HeroGroupFightLayoutView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.heroContainer = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/area")

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

var_0_0.MoveOffsetX = 125

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.isSeason166Episode = Season166HeroGroupModel.instance:isSeason166Episode()

	if not arg_4_0.isSeason166Episode then
		return
	end

	arg_4_0.goHeroGroupContain = gohelper.findChild(arg_4_0.viewGO, "herogroupcontain")
	arg_4_0.heroGroupContainRectTr = arg_4_0.goHeroGroupContain:GetComponent(gohelper.Type_RectTransform)
	arg_4_0.maxHeroCount = Season166HeroGroupModel.instance:getMaxHeroCountInGroup()

	arg_4_0:initItemName()

	arg_4_0.heroItemList = {}

	for iter_4_0 = 1, arg_4_0.maxHeroCount do
		local var_4_0 = arg_4_0:getUserDataTb_()

		var_4_0.bgRectTr = gohelper.findChildComponent(arg_4_0.viewGO, "herogroupcontain/hero/bg" .. iter_4_0, gohelper.Type_RectTransform)
		var_4_0.posGoTr = gohelper.findChildComponent(arg_4_0.viewGO, "herogroupcontain/area/pos" .. iter_4_0, gohelper.Type_RectTransform)
		var_4_0.bgX = recthelper.getAnchorX(var_4_0.bgRectTr)
		var_4_0.posX = recthelper.getAnchorX(var_4_0.posGoTr)

		table.insert(arg_4_0.heroItemList, var_4_0)
	end

	arg_4_0.mainFrameBgTr = gohelper.findChildComponent(arg_4_0.viewGO, "frame/#go_mainFrameBg", gohelper.Type_RectTransform)
	arg_4_0.mainFrameBgWidth = recthelper.getWidth(arg_4_0.mainFrameBgTr)
	arg_4_0.mainFrameBgX = recthelper.getAnchorX(arg_4_0.mainFrameBgTr)
	arg_4_0.helpFrameBgTr = gohelper.findChildComponent(arg_4_0.viewGO, "frame/#go_helpFrameBg", gohelper.Type_RectTransform)
	arg_4_0.helpFrameBgWidth = recthelper.getWidth(arg_4_0.helpFrameBgTr)
	arg_4_0.helpFrameBgX = recthelper.getAnchorX(arg_4_0.helpFrameBgTr)

	arg_4_0:addEventCb(Season166HeroGroupController.instance, Season166Event.OnCreateHeroItemDone, arg_4_0.onCreateHeroItemDone, arg_4_0)
end

function var_0_0.initItemName(arg_5_0)
	if arg_5_0.maxHeroCount == Season166Enum.MaxHeroCount then
		return
	end

	local var_5_0 = arg_5_0.maxHeroCount / 2 + 1

	for iter_5_0 = 1, Season166Enum.MaxHeroCount do
		local var_5_1 = gohelper.findChild(arg_5_0.heroContainer, "pos" .. iter_5_0)
		local var_5_2 = gohelper.findChild(arg_5_0.viewGO, "herogroupcontain/hero/bg" .. iter_5_0)

		gohelper.setActive(var_5_1, iter_5_0 % var_5_0 ~= 0)
		gohelper.setActive(var_5_2, iter_5_0 % var_5_0 ~= 0)

		if iter_5_0 % var_5_0 == 0 then
			var_5_1.name = string.format("pos_%d_1", iter_5_0)
			var_5_2.name = string.format("bg_%d_1", iter_5_0)
		end

		if var_5_0 <= iter_5_0 and iter_5_0 % var_5_0 ~= 0 then
			local var_5_3 = iter_5_0 - math.floor(iter_5_0 / var_5_0)

			var_5_1.name = "pos" .. var_5_3
			var_5_2.name = "bg" .. var_5_3
		end
	end
end

function var_0_0.onCreateHeroItemDone(arg_6_0)
	for iter_6_0 = 1, arg_6_0.maxHeroCount do
		arg_6_0.heroItemList[iter_6_0].heroItemRectTr = gohelper.findChildComponent(arg_6_0.goHeroGroupContain, "hero/item" .. iter_6_0, gohelper.Type_RectTransform)
	end

	arg_6_0:setUIPos()
end

function var_0_0.setUIPos(arg_7_0)
	local var_7_0 = arg_7_0.maxHeroCount == Season166Enum.MaxHeroCount and 0 or var_0_0.MoveOffsetX

	for iter_7_0 = 1, arg_7_0.maxHeroCount do
		local var_7_1 = arg_7_0.heroItemList[iter_7_0]

		recthelper.setAnchorX(var_7_1.bgRectTr, var_7_1.bgX + var_7_0)
		recthelper.setAnchorX(var_7_1.posGoTr, var_7_1.posX + var_7_0)

		local var_7_2 = var_7_1.heroItemRectTr

		if not gohelper.isNil(var_7_2) then
			local var_7_3 = recthelper.rectToRelativeAnchorPos(var_7_1.posGoTr.position, arg_7_0.heroGroupContainRectTr)

			recthelper.setAnchor(var_7_2, var_7_3.x, var_7_3.y)
		end
	end
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0

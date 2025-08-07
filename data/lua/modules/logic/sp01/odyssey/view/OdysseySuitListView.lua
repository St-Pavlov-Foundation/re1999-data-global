module("modules.logic.sp01.odyssey.view.OdysseySuitListView", package.seeall)

local var_0_0 = class("OdysseySuitListView", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._goRootPath = arg_1_1
end

function var_0_0.onInitView(arg_2_0)
	if arg_2_0._goRootPath then
		arg_2_0.viewGO = gohelper.findChild(arg_2_0.viewGO, arg_2_0._goRootPath)
	end

	arg_2_0._scrollSuit = gohelper.findChildScrollRect(arg_2_0.viewGO, "#scroll_Suit")
	arg_2_0._scrollSuitContent = gohelper.findChild(arg_2_0.viewGO, "#scroll_Suit/Viewport/Content")
	arg_2_0._gosuit = gohelper.findChild(arg_2_0.viewGO, "#scroll_Suit/Viewport/Content/#go_suit")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_3_0)
	arg_3_0._suitItemList = {}

	gohelper.setActive(arg_3_0._gosuit, false)
end

function var_0_0.addEvents(arg_4_0)
	arg_4_0:addEventCb(OdysseyHeroGroupController.instance, OdysseyEvent.OnHeroGroupUpdate, arg_4_0.refreshSuitInfo, arg_4_0)
end

function var_0_0.removeEvents(arg_5_0)
	arg_5_0:addEventCb(OdysseyHeroGroupController.instance, OdysseyEvent.OnHeroGroupUpdate, arg_5_0.refreshSuitInfo, arg_5_0)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:refreshSuitInfo()
end

function var_0_0.refreshSuitInfo(arg_7_0)
	local var_7_0 = OdysseyConfig.instance:getEquipSuitConfigList()
	local var_7_1 = var_7_0 ~= nil and var_7_0[1] ~= nil

	gohelper.setActive(arg_7_0._scrollSuit, var_7_1)

	if var_7_1 == false then
		return
	end

	local var_7_2 = arg_7_0._suitItemList
	local var_7_3 = 0
	local var_7_4 = #var_7_2
	local var_7_5 = {}
	local var_7_6 = OdysseyHeroGroupModel.instance:getCurHeroGroup()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_7 = OdysseyConfig.instance:getEquipSuitAllEffect(iter_7_1.id)

		if var_7_7 == nil or next(var_7_7) == nil then
			logError(string.format("奥德赛 套装 id : %s 没有套装效果数据", tostring(iter_7_1.id)))
		else
			local var_7_8 = var_7_6:getOdysseyEquipSuit(iter_7_1.id)

			if var_7_8 and var_7_8.count > 0 then
				var_7_3 = var_7_3 + 1

				local var_7_9

				if var_7_4 < var_7_3 then
					local var_7_10 = gohelper.clone(arg_7_0._gosuit, arg_7_0._scrollSuitContent)
					local var_7_11 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_10, OdysseySuitListItem)

					table.insert(var_7_2, var_7_11)
				else
					local var_7_12 = var_7_2[var_7_3]
				end

				table.insert(var_7_5, var_7_8)
			end
		end
	end

	table.sort(var_7_5, arg_7_0.sortSuit)

	for iter_7_2 = 1, var_7_3 do
		local var_7_13 = var_7_5[iter_7_2]
		local var_7_14 = var_7_2[iter_7_2]
		local var_7_15 = OdysseyConfig.instance:getEquipSuitConfig(var_7_13.suitId)

		var_7_14:setActive(true)
		var_7_14:setInfo(var_7_13.suitId, var_7_15)
		var_7_14:refreshUI()
	end

	if var_7_3 < var_7_4 then
		for iter_7_3 = var_7_3 + 1, var_7_4 do
			var_7_2[iter_7_3]:setActive(false)
		end
	end
end

function var_0_0.sortSuit(arg_8_0, arg_8_1)
	if arg_8_0.level == arg_8_1.level then
		return arg_8_0.count > arg_8_1.count
	end

	return arg_8_0.level > arg_8_1.level
end

return var_0_0

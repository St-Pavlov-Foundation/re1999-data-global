module("modules.logic.enemyinfo.view.tab.EnemyInfoWeekWalk_2TabView", package.seeall)

local var_0_0 = class("EnemyInfoWeekWalk_2TabView", UserDataDispose)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goweekwalktab = gohelper.findChild(arg_1_0.viewGO, "#go_tab_container/#go_weekwalkhearttab")
	arg_1_0.simagebattlelistbg = gohelper.findChildSingleImage(arg_1_0.goweekwalktab, "#simage_battlelistbg")
	arg_1_0.gobattleitem = gohelper.findChild(arg_1_0.goweekwalktab, "scroll_battle/Viewport/battlelist/#go_battlebtntemplate")

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
	gohelper.setActive(arg_4_0.gobattleitem, false)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._mapId = arg_5_0.viewParam.mapId

	local var_5_0 = WeekWalk_2Model.instance:getInfo():getLayerInfo(arg_5_0._mapId)
	local var_5_1 = var_5_0.battleIds
	local var_5_2 = arg_5_0.viewParam.selectBattleId or var_5_1[1]

	arg_5_0._battleIds = var_5_1
	arg_5_0._btnList = {}
	arg_5_0._statusList = {}

	local var_5_3 = 5
	local var_5_4 = math.min(var_5_3, #var_5_0.battleInfos)
	local var_5_5 = WeekWalk_2Enum.MaxStar

	for iter_5_0 = 1, var_5_4 do
		local var_5_6 = gohelper.cloneInPlace(arg_5_0.gobattleitem).gameObject
		local var_5_7 = gohelper.findChildButton(var_5_6, "btn")
		local var_5_8 = gohelper.findChildText(var_5_6, "txt")
		local var_5_9 = gohelper.findChild(var_5_6, "selectIcon")

		var_5_8.text = "0" .. iter_5_0

		local var_5_10 = var_5_1[iter_5_0]
		local var_5_11 = var_5_0:getBattleInfoByBattleId(var_5_10)
		local var_5_12 = gohelper.findChild(var_5_6, "star2")
		local var_5_13 = gohelper.findChild(var_5_6, "star3")
		local var_5_14 = var_5_5 <= 2 and var_5_12 or var_5_13

		gohelper.setActive(var_5_12, false)
		gohelper.setActive(var_5_13, false)
		gohelper.setActive(var_5_14, true)

		local var_5_15 = var_5_14.transform
		local var_5_16 = var_5_15.childCount
		local var_5_17 = {
			var_5_9,
			var_5_8
		}

		for iter_5_1 = 1, var_5_16 do
			local var_5_18 = var_5_15:GetChild(iter_5_1 - 1):GetComponentInChildren(gohelper.Type_Image)

			var_5_18.enabled = false

			local var_5_19 = arg_5_0.tabParentView:getResInst(arg_5_0.viewContainer._viewSetting.otherRes.weekwalkheart_star, var_5_18.gameObject)

			WeekWalk_2Helper.setCupEffect(var_5_19, var_5_11:getCupInfo(iter_5_1))
			table.insert(var_5_17, var_5_18)
		end

		var_5_7:AddClickListener(arg_5_0.selectBattleId, arg_5_0, var_5_10)
		gohelper.setActive(var_5_6, true)
		table.insert(arg_5_0._statusList, var_5_17)
		table.insert(arg_5_0._btnList, var_5_7)
	end

	gohelper.setActive(arg_5_0.goweekwalktab, true)
	arg_5_0.enemyInfoMo:setShowLeftTab(true)
	arg_5_0:selectBattleId(var_5_2)
end

function var_0_0.selectBattleId(arg_6_0, arg_6_1)
	arg_6_0.enemyInfoMo:updateBattleId(arg_6_1)

	if not arg_6_0._statusList then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._battleIds) do
		local var_6_0 = iter_6_1 == arg_6_1
		local var_6_1 = arg_6_0._statusList[iter_6_0]

		if not var_6_1 then
			break
		end

		gohelper.setActive(var_6_1[1], var_6_0)

		if var_6_0 then
			SLFramework.UGUI.GuiHelper.SetColor(var_6_1[2], "#FFFFFF")
			SLFramework.UGUI.GuiHelper.SetColor(var_6_1[3], "#FFFFFF")
			SLFramework.UGUI.GuiHelper.SetColor(var_6_1[4], "#FFFFFF")
		else
			SLFramework.UGUI.GuiHelper.SetColor(var_6_1[2], "#6c6f64")
			SLFramework.UGUI.GuiHelper.SetColor(var_6_1[3], "#C1C5B6")
			SLFramework.UGUI.GuiHelper.SetColor(var_6_1[4], "#C1C5B6")
		end

		if var_6_1[5] then
			SLFramework.UGUI.GuiHelper.SetColor(var_6_1[5], var_6_0 and "#FFFFFF" or "#C1C5B6")
		end
	end
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0.simagebattlelistbg:UnLoadImage()

	if arg_8_0._btnList then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0._btnList) do
			iter_8_1:RemoveClickListener()
		end
	end
end

return var_0_0

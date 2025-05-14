module("modules.logic.enemyinfo.comp.FightEntityResistanceComp", package.seeall)

local var_0_0 = class("FightEntityResistanceComp", UserDataDispose)

var_0_0.FightResistancePath = "ui/viewres/fight/fightresistance.prefab"

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0.goContainer = arg_1_1
	arg_1_0.viewContainer = arg_1_2
end

var_0_0.ScreenPosIntervalX = 0

function var_0_0.onInitView(arg_2_0)
	arg_2_0.go = arg_2_0.viewContainer:getResInst(var_0_0.FightResistancePath, arg_2_0.goContainer)
	arg_2_0.scroll = gohelper.findChild(arg_2_0.go, "scroll_view"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_2_0.goResistanceItem = gohelper.findChild(arg_2_0.go, "scroll_view/Viewport/Content/#go_resistanceitem")

	gohelper.setActive(arg_2_0.goResistanceItem, false)

	arg_2_0.click = gohelper.getClickWithDefaultAudio(arg_2_0.go)

	arg_2_0.click:AddClickListener(arg_2_0.onClickResistance, arg_2_0)

	arg_2_0.resistanceItemList = {}
	arg_2_0.rect = arg_2_0.go:GetComponent(gohelper.Type_RectTransform)
end

function var_0_0.setParent(arg_3_0, arg_3_1)
	arg_3_0.scroll.parentGameObject = arg_3_1
end

function var_0_0.onClickResistance(arg_4_0)
	if not arg_4_0.resistanceDict then
		return
	end

	arg_4_0.screenPos = recthelper.uiPosToScreenPos(arg_4_0.rect)
	arg_4_0.screenPos.x = arg_4_0.screenPos.x - var_0_0.ScreenPosIntervalX

	FightResistanceTipController.instance:openFightResistanceTipView(arg_4_0.resistanceDict, arg_4_0.screenPos)
end

function var_0_0.refresh(arg_5_0, arg_5_1)
	arg_5_0.resistanceDict = arg_5_1

	if not arg_5_1 then
		gohelper.setActive(arg_5_0.goContainer, false)

		return
	end

	arg_5_0.showResistanceList = arg_5_0.showResistanceList or {}

	tabletool.clear(arg_5_0.showResistanceList)

	for iter_5_0, iter_5_1 in pairs(FightEnum.Resistance) do
		local var_5_0 = arg_5_0.resistanceDict[iter_5_0] or 0

		if var_5_0 > 0 then
			table.insert(arg_5_0.showResistanceList, {
				resistanceId = iter_5_1,
				value = var_5_0
			})
		end
	end

	table.sort(arg_5_0.showResistanceList, var_0_0.sortResistance)

	for iter_5_2, iter_5_3 in ipairs(arg_5_0.showResistanceList) do
		local var_5_1 = arg_5_0.resistanceItemList[iter_5_2] or arg_5_0:createResistanceItem()

		gohelper.setActive(var_5_1.go, true)

		local var_5_2 = lua_character_attribute.configDict[iter_5_3.resistanceId]

		if var_5_2 then
			UISpriteSetMgr.instance:setBuffSprite(var_5_1.icon, var_5_2.icon)
		end
	end

	local var_5_3 = #arg_5_0.showResistanceList

	if var_5_3 > 0 then
		for iter_5_4 = var_5_3 + 1, #arg_5_0.resistanceItemList do
			gohelper.setActive(arg_5_0.resistanceItemList[iter_5_4].go, false)
		end

		arg_5_0.scroll.horizontalNormalizedPosition = 0

		gohelper.setActive(arg_5_0.goContainer, true)
	else
		gohelper.setActive(arg_5_0.goContainer, false)
	end
end

function var_0_0.getResistanceValue(arg_6_0, arg_6_1)
	local var_6_0 = FightHelper.getResistanceKeyById(arg_6_1)

	return var_6_0 and arg_6_0.resistanceDict[var_6_0] or 0
end

function var_0_0.createResistanceItem(arg_7_0)
	local var_7_0 = arg_7_0:getUserDataTb_()

	var_7_0.go = gohelper.cloneInPlace(arg_7_0.goResistanceItem)
	var_7_0.icon = gohelper.findChildImage(var_7_0.go, "normal/#image_icon")

	table.insert(arg_7_0.resistanceItemList, var_7_0)

	return var_7_0
end

function var_0_0.sortResistance(arg_8_0, arg_8_1)
	local var_8_0 = lua_character_attribute.configDict[arg_8_0.resistanceId]
	local var_8_1 = lua_character_attribute.configDict[arg_8_1.resistanceId]

	return var_8_0.sortId < var_8_1.sortId
end

function var_0_0.destroy(arg_9_0)
	arg_9_0.click:RemoveClickListener()

	arg_9_0.click = nil
	arg_9_0.resistanceItemList = nil

	arg_9_0:__onDispose()
end

return var_0_0

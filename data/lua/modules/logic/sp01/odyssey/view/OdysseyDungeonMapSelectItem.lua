module("modules.logic.sp01.odyssey.view.OdysseyDungeonMapSelectItem", package.seeall)

local var_0_0 = class("OdysseyDungeonMapSelectItem", LuaCompBase)
local var_0_1 = Vector2(200, 200)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.config = arg_1_1[1]
	arg_1_0.mapSelectView = arg_1_1[2]
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.trans = arg_2_0.go.transform
	arg_2_0.goSelect = gohelper.findChild(arg_2_0.go, "go_select")
	arg_2_0.txtName = gohelper.findChildText(arg_2_0.go, "name/txt_name")
	arg_2_0.goMercenary = gohelper.findChild(arg_2_0.go, "go_mercenary")
	arg_2_0.goMercenaryItem = gohelper.findChild(arg_2_0.go, "go_mercenary/go_mercenaryItem")
	arg_2_0.goHeroItem = gohelper.findChild(arg_2_0.go, "go_heroItem")
	arg_2_0.goMainTask = gohelper.findChild(arg_2_0.go, "go_mainTask")
	arg_2_0.goMainTaskEffect = gohelper.findChild(arg_2_0.go, "go_mainTask/icon/glow2")
	arg_2_0.goLock = gohelper.findChild(arg_2_0.go, "go_lock")
	arg_2_0.goInfo = gohelper.findChild(arg_2_0.go, "go_info")
	arg_2_0.txtExplore = gohelper.findChildText(arg_2_0.go, "go_info/txt_explore")
	arg_2_0.txtLevel = gohelper.findChildText(arg_2_0.go, "go_info/txt_level")
	arg_2_0.goReddot = gohelper.findChild(arg_2_0.go, "go_reddot")

	arg_2_0.addBoxColliderListener(arg_2_0.go, arg_2_0.onClickDown, arg_2_0)
	gohelper.setActive(arg_2_0.goSelect, false)
	gohelper.setActive(arg_2_0.goMainTaskEffect, false)
end

function var_0_0.addBoxColliderListener(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = ZProj.BoxColliderClickListener.Get(arg_3_0)

	var_3_0:SetIgnoreUI(true)
	var_3_0:AddClickListener(arg_3_1, arg_3_2)
end

function var_0_0.onClickDown(arg_4_0)
	arg_4_0.mapSelectView:onMapItemClickDown(arg_4_0)
end

function var_0_0.addEvents(arg_5_0)
	OdysseyDungeonController.instance:registerCallback(OdysseyEvent.OnUpdateElementPush, arg_5_0.updateInfo, arg_5_0)
end

function var_0_0.removeEvents(arg_6_0)
	OdysseyDungeonController.instance:unregisterCallback(OdysseyEvent.OnUpdateElementPush, arg_6_0.updateInfo, arg_6_0)
end

function var_0_0.updateInfo(arg_7_0)
	arg_7_0.txtName.text = arg_7_0.config.mapName
	arg_7_0.curInMapId = OdysseyDungeonModel.instance:getHeroInMapId()

	gohelper.setActive(arg_7_0.goHeroItem, arg_7_0.curInMapId == arg_7_0.config.id)

	arg_7_0.mapInfoMo = OdysseyDungeonModel.instance:getMapInfo(arg_7_0.config.id)

	if arg_7_0.mapInfoMo then
		arg_7_0.txtExplore.text = string.format("%s%%", math.floor(arg_7_0.mapInfoMo.exploreValue / 10))

		local var_7_0 = string.splitToNumber(arg_7_0.config.recommendLevel, "#")

		arg_7_0.txtLevel.text = string.format("%s-%s", var_7_0[1], var_7_0[2])
	end

	local var_7_1, var_7_2 = OdysseyDungeonModel.instance:getCurMainElement()

	arg_7_0.canShowMainTask = var_7_2 and var_7_2.mapId == arg_7_0.config.id

	gohelper.setActive(arg_7_0.goMainTask, arg_7_0.canShowMainTask)
	gohelper.setActive(arg_7_0.goLock, not arg_7_0.mapInfoMo)
	gohelper.setActive(arg_7_0.goInfo, arg_7_0.mapInfoMo)

	local var_7_3 = OdysseyDungeonModel.instance:getMercenaryElementsByMap(arg_7_0.config.id)

	gohelper.setActive(arg_7_0.goMercenary, #var_7_3 > 0)

	if #var_7_3 > 0 then
		gohelper.CreateObjList(arg_7_0, arg_7_0.onMercenaryItemShow, var_7_3, arg_7_0.goMercenary, arg_7_0.goMercenaryItem)
	end
end

function var_0_0.onMercenaryItemShow(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	gohelper.setActive(arg_8_1, arg_8_2)
end

function var_0_0.setSelectState(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0.goSelect, arg_9_1)
	gohelper.setActive(arg_9_0.goMainTaskEffect, false)
end

function var_0_0.playMainTaskEffect(arg_10_0)
	gohelper.setActive(arg_10_0.goMainTaskEffect, false)
	gohelper.setActive(arg_10_0.goMainTaskEffect, true)
end

function var_0_0.refreshReddotShowState(arg_11_0)
	local var_11_0 = OdysseyDungeonModel.instance:checkHasNewUnlock(OdysseyEnum.LocalSaveKey.MapNew, {
		arg_11_0.config.id
	})

	gohelper.setActive(arg_11_0.goReddot, var_11_0 and arg_11_0.mapInfoMo)
end

function var_0_0.onDestroy(arg_12_0)
	return
end

return var_0_0

module("modules.logic.versionactivity2_4.pinball.view.PinballBuildView", package.seeall)

local var_0_0 = class("PinballBuildView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._golist = gohelper.findChild(arg_1_0.viewGO, "#go_list")
	arg_1_0._goitem = gohelper.findChild(arg_1_0._golist, "#go_item")
	arg_1_0._gobuild = gohelper.findChild(arg_1_0.viewGO, "#go_build")
	arg_1_0._godone = gohelper.findChild(arg_1_0.viewGO, "#go_done")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "#go_lock")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._txttitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_title")
	arg_1_0._txtdesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "#scroll_dec/Viewport/Content/#txt_dec")
	arg_1_0._btnBuild = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_build/#btn_build")
	arg_1_0._btnLock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_lock/#btn_lock")
	arg_1_0._goeffectitem = gohelper.findChild(arg_1_0.viewGO, "#go_add/go_item")
	arg_1_0._gocostitem1 = gohelper.findChild(arg_1_0.viewGO, "#go_build/#go_currency/go_item")
	arg_1_0._gocostitem2 = gohelper.findChild(arg_1_0.viewGO, "#go_lock/#go_currency/go_item")
	arg_1_0._topCurrencyRoot = gohelper.findChild(arg_1_0.viewGO, "#go_topright")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.onClickModalMask, arg_2_0)
	arg_2_0._btnBuild:AddClickListener(arg_2_0.onBuildClick, arg_2_0)
	arg_2_0._btnLock:AddClickListener(arg_2_0.onLockClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnBuild:RemoveClickListener()
	arg_3_0._btnLock:RemoveClickListener()
end

function var_0_0.onClickModalMask(arg_4_0)
	gohelper.setActive(arg_4_0.viewGO, false)
	arg_4_0:closeThis()
end

function var_0_0.onOpen(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio3)
	arg_5_0:createCurrencyItem()

	arg_5_0._items = {}

	local var_5_0 = PinballConfig.instance:getAllBuildingCo(VersionActivity2_4Enum.ActivityId.Pinball, arg_5_0.viewParam.size)

	gohelper.CreateObjList(arg_5_0, arg_5_0.createItem, var_5_0, arg_5_0._golist, arg_5_0._goitem, PinballBuildItem)
	arg_5_0:onSelect(1)
end

function var_0_0.createItem(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_1:initData(arg_6_2, arg_6_3)

	arg_6_0._items[arg_6_3] = arg_6_1

	local var_6_0 = gohelper.findChildButtonWithAudio(arg_6_1.go, "#btn_click")

	arg_6_0:addClickCb(var_6_0, arg_6_0.onSelect, arg_6_0, arg_6_3)
end

function var_0_0.onSelect(arg_7_0, arg_7_1)
	arg_7_0._curSelectIndex = arg_7_1

	for iter_7_0, iter_7_1 in pairs(arg_7_0._items) do
		iter_7_1:setSelect(arg_7_1 == iter_7_1._index)

		if arg_7_1 == iter_7_1._index then
			arg_7_0:_refreshView(iter_7_1)
		end
	end
end

function var_0_0.createCurrencyItem(arg_8_0)
	local var_8_0 = {
		PinballEnum.ResType.Wood,
		PinballEnum.ResType.Mine,
		PinballEnum.ResType.Stone
	}

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_1 = arg_8_0:getResInst(arg_8_0.viewContainer._viewSetting.otherRes.currency, arg_8_0._topCurrencyRoot)

		MonoHelper.addNoUpdateLuaComOnceToGo(var_8_1, PinballCurrencyItem):setCurrencyType(iter_8_1)
	end
end

function var_0_0._refreshView(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:isLock()
	local var_9_1 = arg_9_1:isDone()
	local var_9_2 = arg_9_1._data

	gohelper.setActive(arg_9_0._golock, var_9_0)
	gohelper.setActive(arg_9_0._godone, var_9_1)
	gohelper.setActive(arg_9_0._gobuild, not var_9_0 and not var_9_1)

	arg_9_0._txttitle.text = var_9_2.desc
	arg_9_0._txtdesc.text = var_9_2.desc2

	arg_9_0:updateEffect(var_9_2)
	arg_9_0:updateCost(var_9_2)
	ZProj.UGUIHelper.SetGrayscale(arg_9_0._btnBuild.gameObject, not not arg_9_0._costNoEnough)
end

function var_0_0.updateEffect(arg_10_0, arg_10_1)
	local var_10_0 = {}
	local var_10_1 = arg_10_1.effect

	if not string.nilorempty(var_10_1) then
		local var_10_2 = GameUtil.splitString2(var_10_1, true)

		for iter_10_0, iter_10_1 in pairs(var_10_2) do
			if iter_10_1[1] == PinballEnum.BuildingEffectType.AddScore then
				table.insert(var_10_0, {
					resType = PinballEnum.ResType.Score,
					value = iter_10_1[2]
				})
			elseif iter_10_1[1] == PinballEnum.BuildingEffectType.AddFood then
				table.insert(var_10_0, {
					resType = PinballEnum.ResType.Food,
					value = iter_10_1[2]
				})
			elseif iter_10_1[1] == PinballEnum.BuildingEffectType.CostFood then
				table.insert(var_10_0, {
					resType = PinballEnum.ResType.Food,
					value = iter_10_1[2],
					text = luaLang("pinball_food_need")
				})
			elseif iter_10_1[1] == PinballEnum.BuildingEffectType.AddPlay then
				table.insert(var_10_0, {
					resType = PinballEnum.ResType.Play,
					value = iter_10_1[2]
				})
			elseif iter_10_1[1] == PinballEnum.BuildingEffectType.AddPlayDemand then
				table.insert(var_10_0, {
					resType = PinballEnum.ResType.Play,
					value = iter_10_1[2],
					text = luaLang("pinball_play_need")
				})
			end
		end
	end

	gohelper.CreateObjList(arg_10_0, arg_10_0._createEffectItem, var_10_0, nil, arg_10_0._goeffectitem)
end

function var_0_0.updateCost(arg_11_0, arg_11_1)
	local var_11_0 = {}
	local var_11_1 = arg_11_1.cost

	if not string.nilorempty(var_11_1) then
		local var_11_2 = GameUtil.splitString2(var_11_1, true)

		for iter_11_0, iter_11_1 in pairs(var_11_2) do
			table.insert(var_11_0, {
				resType = iter_11_1[1],
				value = iter_11_1[2]
			})
		end
	end

	arg_11_0._costNoEnough = nil

	gohelper.CreateObjList(arg_11_0, arg_11_0._createCostItem, var_11_0, nil, arg_11_0._gocostitem1)
	gohelper.CreateObjList(arg_11_0, arg_11_0._createCostItem, var_11_0, nil, arg_11_0._gocostitem2)
end

function var_0_0._createCostItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = gohelper.findChildTextMesh(arg_12_1, "#txt_num")
	local var_12_1 = gohelper.findChildImage(arg_12_1, "#txt_num/#image_icon")
	local var_12_2 = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][arg_12_2.resType]

	if not var_12_2 then
		logError("资源配置不存在" .. arg_12_2.resType)

		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(var_12_1, var_12_2.icon)

	local var_12_3 = ""

	if arg_12_2.value > PinballModel.instance:getResNum(arg_12_2.resType) then
		var_12_3 = "<color=#FC8A6A>"
		arg_12_0._costNoEnough = arg_12_0._costNoEnough or var_12_2.name
	end

	var_12_0.text = string.format("%s-%d", var_12_3, arg_12_2.value)
end

function var_0_0._createEffectItem(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = gohelper.findChildTextMesh(arg_13_1, "#txt_num")
	local var_13_1 = gohelper.findChildImage(arg_13_1, "#txt_num/#image_icon")
	local var_13_2 = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][arg_13_2.resType]

	if not var_13_2 then
		logError("资源配置不存在" .. arg_13_2.resType)

		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(var_13_1, var_13_2.icon)

	var_13_0.text = GameUtil.getSubPlaceholderLuaLang(luaLang("PinballBuildView_createEffectItem"), {
		arg_13_2.text or var_13_2.name,
		arg_13_2.value
	})
end

function var_0_0.onBuildClick(arg_14_0)
	if arg_14_0._costNoEnough then
		GameFacade.showToast(ToastEnum.DiamondBuy, arg_14_0._costNoEnough)

		return
	end

	Activity178Rpc.instance:sendAct178Build(VersionActivity2_4Enum.ActivityId.Pinball, arg_14_0._items[arg_14_0._curSelectIndex]._data.id, PinballEnum.BuildingOperType.Build, arg_14_0.viewParam.index)
	arg_14_0:onClickModalMask()
end

function var_0_0.onLockClick(arg_15_0)
	arg_15_0._items[arg_15_0._curSelectIndex]:isLock(true)
end

return var_0_0

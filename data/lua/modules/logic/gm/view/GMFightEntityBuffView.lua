module("modules.logic.gm.view.GMFightEntityBuffView", package.seeall)

local var_0_0 = class("GMFightEntityBuffView", BaseView)

var_0_0.ClickSearchItem = "ClickSearchItem"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._maskGO = gohelper.findChild(arg_1_0.viewGO, "buff/searchList")
	arg_1_0._scrollTr = gohelper.findChild(arg_1_0.viewGO, "buff/searchList/scroll").transform
	arg_1_0._input = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "buff/add/input")
	arg_1_0._btnAdd = gohelper.findChildButton(arg_1_0.viewGO, "buff/add/btnAdd")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnAdd:AddClickListener(arg_2_0._onClickAddBuff, arg_2_0)
	SLFramework.UGUI.UIClickListener.Get(arg_2_0._input.gameObject):AddClickListener(arg_2_0._onClickInpItem, arg_2_0, nil)
	SLFramework.UGUI.UIClickListener.Get(arg_2_0._maskGO):AddClickListener(arg_2_0._onClickMask, arg_2_0, nil)
	arg_2_0._input:AddOnValueChanged(arg_2_0._onInpValueChanged, arg_2_0)
	GMController.instance:registerCallback(var_0_0.ClickSearchItem, arg_2_0._onClickItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnAdd:RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(arg_3_0._input.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(arg_3_0._maskGO):RemoveClickListener()
	arg_3_0._input:RemoveOnValueChanged()
	GMController.instance:unregisterCallback(var_0_0.ClickSearchItem, arg_3_0._onClickItem, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:_hideScroll()
	arg_4_0._input:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMEntityBuffSearch, ""))
end

function var_0_0._onClickAddBuff(arg_5_0)
	local var_5_0 = tonumber(arg_5_0._input:GetText())

	if var_5_0 and lua_skill_buff.configDict[var_5_0] then
		PlayerPrefsHelper.setString(PlayerPrefsKey.GMEntityBuffSearch, tostring(var_5_0))
		GameFacade.showToast(ToastEnum.IconId, "add buff " .. var_5_0)

		local var_5_1 = GMFightEntityModel.instance.entityMO

		GMRpc.instance:sendGMRequest(string.format("fightAddBuff %s %s", tostring(var_5_1.id), tostring(var_5_0)))

		arg_5_0._oldBuffUidDict = {}

		for iter_5_0, iter_5_1 in ipairs(var_5_1:getBuffList()) do
			arg_5_0._oldBuffUidDict[iter_5_1.id] = true
		end

		FightRpc.instance:sendEntityInfoRequest(var_5_1.id)
		arg_5_0:addEventCb(FightController.instance, FightEvent.onReceiveEntityInfoReply, arg_5_0._onGetEntityInfo, arg_5_0)
	else
		GameFacade.showToast(ToastEnum.IconId, "buff not exist " .. arg_5_0._input:GetText())
	end
end

function var_0_0._onGetEntityInfo(arg_6_0, arg_6_1)
	arg_6_0:removeEventCb(FightController.instance, FightEvent.onReceiveEntityInfoReply, arg_6_0._onGetEntityInfo, arg_6_0)

	local var_6_0 = GMFightEntityModel.instance.entityMO

	if not var_6_0 then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(var_6_0:getBuffList()) do
		if not arg_6_0._oldBuffUidDict[iter_6_1.id] then
			logError("add buff " .. iter_6_1.buffId)

			local var_6_1 = FightHelper.getEntity(var_6_0.id)

			if var_6_1 and var_6_1.buff then
				var_6_1.buff:addBuff(iter_6_1, false, 0)
				FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, var_6_0.id, FightEnum.EffectType.BUFFADD, iter_6_1.buffId, iter_6_1.uid, 0)
			end
		else
			FightController.instance:dispatchEvent(FightEvent.GMForceRefreshNameUIBuff, var_6_0.id)
		end
	end
end

function var_0_0._onClickInpItem(arg_7_0)
	arg_7_0:_showScroll()
end

function var_0_0._onClickMask(arg_8_0)
	arg_8_0:_hideScroll()
end

function var_0_0._showScroll(arg_9_0)
	gohelper.setActive(arg_9_0._maskGO, true)
	arg_9_0:_checkBuildItems()
end

function var_0_0._hideScroll(arg_10_0)
	gohelper.setActive(arg_10_0._maskGO, false)
end

function var_0_0._onClickItem(arg_11_0, arg_11_1)
	arg_11_0._input:SetText(arg_11_1.buffId)
	arg_11_0:_hideScroll()
end

function var_0_0._onInpValueChanged(arg_12_0, arg_12_1)
	arg_12_0:_checkBuildItems()
end

function var_0_0._checkBuildItems(arg_13_0)
	if not arg_13_0._searchScrollView then
		local var_13_0 = ListScrollParam.New()

		var_13_0.scrollGOPath = "buff/searchList/scroll"
		var_13_0.prefabType = ScrollEnum.ScrollPrefabFromView
		var_13_0.prefabUrl = "buff/searchList/scroll/item"
		var_13_0.cellClass = GMFightEntityBuffSearchItem
		var_13_0.scrollDir = ScrollEnum.ScrollDirV
		var_13_0.lineCount = 1
		var_13_0.cellWidth = 450
		var_13_0.cellHeight = 50
		var_13_0.cellSpaceH = 0
		var_13_0.cellSpaceV = 0
		arg_13_0._searchScrollModel = ListScrollModel.New()
		arg_13_0._searchScrollView = LuaListScrollView.New(arg_13_0._searchScrollModel, var_13_0)

		arg_13_0:addChildView(arg_13_0._searchScrollView)

		arg_13_0._buffList = {}

		for iter_13_0, iter_13_1 in ipairs(lua_skill_buff.configList) do
			local var_13_1 = {
				buffId = tostring(iter_13_1.id),
				name = iter_13_1.name
			}

			table.insert(arg_13_0._buffList, var_13_1)
		end
	end

	local var_13_2
	local var_13_3 = arg_13_0._input:GetText()

	if string.nilorempty(var_13_3) then
		var_13_2 = arg_13_0._buffList
	else
		if arg_13_0._tempList then
			tabletool.clear(arg_13_0._tempList)
		else
			arg_13_0._tempList = {}
		end

		for iter_13_2, iter_13_3 in ipairs(arg_13_0._buffList) do
			if string.find(iter_13_3.name, var_13_3) or string.find(iter_13_3.buffId, var_13_3) == 1 then
				table.insert(arg_13_0._tempList, iter_13_3)
			end
		end

		var_13_2 = arg_13_0._tempList
	end

	local var_13_4 = Mathf.Clamp(#var_13_2, 1, 10)

	recthelper.setHeight(arg_13_0._scrollTr, var_13_4 * 50)
	arg_13_0._searchScrollModel:setList(var_13_2)
end

return var_0_0

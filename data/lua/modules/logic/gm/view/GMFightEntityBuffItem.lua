module("modules.logic.gm.view.GMFightEntityBuffItem", package.seeall)

local var_0_0 = class("GMFightEntityBuffItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._id = gohelper.findChildTextMeshInputField(arg_1_1, "id")
	arg_1_0._name = gohelper.findChildText(arg_1_1, "name")
	arg_1_0._type = gohelper.findChildText(arg_1_1, "type")
	arg_1_0._set = gohelper.findChildText(arg_1_1, "set")
	arg_1_0._duration = gohelper.findChildTextMeshInputField(arg_1_1, "duration")
	arg_1_0._count = gohelper.findChildTextMeshInputField(arg_1_1, "count")
	arg_1_0._layer = gohelper.findChildTextMeshInputField(arg_1_1, "layer")
	arg_1_0._btnDel = gohelper.findChildButtonWithAudio(arg_1_1, "btnDel")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnDel:AddClickListener(arg_2_0._onClickDel, arg_2_0)
	arg_2_0._duration:AddOnEndEdit(arg_2_0._onAddEditDuration, arg_2_0)
	arg_2_0._count:AddOnEndEdit(arg_2_0._onAddEditCount, arg_2_0)
	arg_2_0._layer:AddOnEndEdit(arg_2_0._onAddEditLayer, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnDel:RemoveClickListener()
	arg_3_0._duration:RemoveOnEndEdit()
	arg_3_0._count:RemoveOnEndEdit()
	arg_3_0._layer:RemoveOnEndEdit()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1

	local var_4_0 = lua_skill_buff.configDict[arg_4_0._mo.buffId]
	local var_4_1 = var_4_0 and lua_skill_bufftype.configDict[var_4_0.typeId]

	arg_4_0._id:SetText(tostring(arg_4_0._mo.buffId))

	arg_4_0._name.text = var_4_0 and var_4_0.name or ""
	arg_4_0._type.text = var_4_0 and tostring(var_4_0.typeId) or ""
	arg_4_0._set.text = var_4_1 and tostring(var_4_1.type) or ""

	arg_4_0._duration:SetText(tostring(arg_4_0._mo.duration) or "")
	arg_4_0._count:SetText(tostring(arg_4_0._mo.count) or "")
	arg_4_0._layer:SetText(tostring(arg_4_0._mo.layer) or "")
end

function var_0_0._onClickDel(arg_5_0)
	local var_5_0 = lua_skill_buff.configDict[arg_5_0._mo.buffId]

	if var_5_0 then
		GameFacade.showToast(ToastEnum.IconId, "del buff " .. var_5_0.name)
	else
		GameFacade.showToast(ToastEnum.IconId, "buff config not exist")
	end

	local var_5_1 = GMFightEntityModel.instance.entityMO

	GMRpc.instance:sendGMRequest(string.format("fightDelBuff %s %s", tostring(var_5_1.id), tostring(arg_5_0._mo.uid)))
	var_5_1:delBuff(arg_5_0._mo.uid)

	local var_5_2 = FightHelper.getEntity(var_5_1.id)

	if var_5_2 and var_5_2.buff then
		var_5_2.buff:delBuff(arg_5_0._mo.uid)
	end

	local var_5_3 = FightLocalDataMgr.instance.entityMgr:getById(var_5_1.id)

	if var_5_3 then
		var_5_3:delBuff(arg_5_0._mo.uid)
	end

	FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, var_5_1.id, FightEnum.EffectType.BUFFDEL, arg_5_0._mo.buffId, arg_5_0._mo.uid, 0)
	FightRpc.instance:sendEntityInfoRequest(var_5_1.id)
end

function var_0_0._onAddEditDuration(arg_6_0, arg_6_1)
	local var_6_0 = tonumber(arg_6_1)

	if var_6_0 and (var_6_0 == -1 or var_6_0 > 0) then
		local var_6_1 = GMFightEntityModel.instance.entityMO

		arg_6_0._mo.duration = var_6_0

		local var_6_2 = FightLocalDataMgr.instance.entityMgr:getById(var_6_1.id)

		if var_6_2 then
			local var_6_3 = var_6_2:getBuffMO(arg_6_0._mo.uid)

			if var_6_3 then
				var_6_3.duration = var_6_0
			end
		end

		GMRpc.instance:sendGMRequest(string.format("fightChangeBuff %s %s %d %d %d", var_6_1.id, arg_6_0._mo.id, arg_6_0._mo.count, var_6_0, arg_6_0._mo.layer))
		FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, var_6_1.id, FightEnum.EffectType.BUFFUPDATE, arg_6_0._mo.buffId, arg_6_0._mo.uid, 0)
	else
		arg_6_0._duration:SetText(tostring(arg_6_0._mo.duration) or "")
		GameFacade.showToast(ToastEnum.IconId, "修正数值错误")
	end
end

function var_0_0._onAddEditCount(arg_7_0, arg_7_1)
	local var_7_0 = tonumber(arg_7_1)

	if var_7_0 and var_7_0 > 0 then
		local var_7_1 = GMFightEntityModel.instance.entityMO

		arg_7_0._mo.count = var_7_0

		local var_7_2 = FightLocalDataMgr.instance.entityMgr:getById(var_7_1.id)

		if var_7_2 then
			local var_7_3 = var_7_2:getBuffMO(arg_7_0._mo.uid)

			if var_7_3 then
				var_7_3.count = var_7_0
			end
		end

		GMRpc.instance:sendGMRequest(string.format("fightChangeBuff %s %s %d %d %d", var_7_1.id, arg_7_0._mo.id, var_7_0, arg_7_0._mo.duration, arg_7_0._mo.layer))
		FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, var_7_1.id, FightEnum.EffectType.BUFFUPDATE, arg_7_0._mo.buffId, arg_7_0._mo.uid, 0)
	else
		arg_7_0._count:SetText(tostring(arg_7_0._mo.count) or "")
		GameFacade.showToast(ToastEnum.IconId, "修正数值错误")
	end
end

function var_0_0._onAddEditLayer(arg_8_0, arg_8_1)
	local var_8_0 = tonumber(arg_8_1)

	if var_8_0 and var_8_0 > 0 then
		local var_8_1 = GMFightEntityModel.instance.entityMO

		arg_8_0._mo.layer = var_8_0

		local var_8_2 = FightLocalDataMgr.instance.entityMgr:getById(var_8_1.id)

		if var_8_2 then
			local var_8_3 = var_8_2:getBuffMO(arg_8_0._mo.uid)

			if var_8_3 then
				var_8_3.layer = var_8_0
			end
		end

		GMRpc.instance:sendGMRequest(string.format("fightChangeBuff %s %s %d %d %d", var_8_1.id, arg_8_0._mo.id, arg_8_0._mo.count, arg_8_0._mo.duration, var_8_0))
		FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, var_8_1.id, FightEnum.EffectType.BUFFUPDATE, arg_8_0._mo.buffId, arg_8_0._mo.uid, 0)
	else
		arg_8_0._layer:SetText(tostring(arg_8_0._mo.layer) or "")
		GameFacade.showToast(ToastEnum.IconId, "修正数值错误")
	end
end

return var_0_0

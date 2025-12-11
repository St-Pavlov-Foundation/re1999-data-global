module("modules.logic.fight.view.preview.SkillEditorBuffSelectItem", package.seeall)

local var_0_0 = class("SkillEditorBuffSelectItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._text = gohelper.findChildText(arg_1_1, "Text")
	arg_1_0._text1 = gohelper.findChildText(arg_1_1, "imgSelect/Text")
	arg_1_0._click = SLFramework.UGUI.UIClickListener.Get(arg_1_1)
	arg_1_0._selectGO = gohelper.findChild(arg_1_1, "imgSelect")
	arg_1_0._textAddLayer1 = nil
	arg_1_0._textAddLayer10 = nil
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClickThis, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._click:RemoveClickListener()

	if arg_3_0._clickLayer1 then
		arg_3_0._clickLayer1:RemoveClickListener()
		arg_3_0._clickLayer10:RemoveClickListener()
	end
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1

	local var_4_0 = arg_4_1.co
	local var_4_1 = SkillEditorBuffSelectModel.instance.attacker

	arg_4_0._text.text = var_4_0.id .. "\n" .. var_4_0.name
	arg_4_0._text1.text = var_4_0.id .. "\n" .. var_4_0.name

	local var_4_2 = arg_4_0:_getEntityBuffMO(var_4_1, var_4_0.id) ~= nil

	gohelper.setActive(arg_4_0._text.gameObject, not var_4_2)
	gohelper.setActive(arg_4_0._selectGO, var_4_2)

	arg_4_0._canShowLayer = false

	if var_4_2 then
		for iter_4_0, iter_4_1 in ipairs(lua_fight_buff_layer_effect.configList) do
			if iter_4_1.id == var_4_0.id then
				arg_4_0._canShowLayer = true

				break
			end
		end
	end

	if arg_4_0._canShowLayer and not arg_4_0._textAddLayer1 then
		local var_4_3 = gohelper.cloneInPlace(arg_4_0._text.gameObject, "layer1")
		local var_4_4 = gohelper.cloneInPlace(arg_4_0._text.gameObject, "layer10")

		arg_4_0._textAddLayer1 = gohelper.findChildText(arg_4_0.go, "layer1")
		arg_4_0._textAddLayer10 = gohelper.findChildText(arg_4_0.go, "layer10")
		arg_4_0._textAddLayer1.text = "<color=white>+1层</color>"
		arg_4_0._textAddLayer10.text = "<color=white>+10层</color>"
		arg_4_0._textAddLayer1.raycastTarget = true
		arg_4_0._textAddLayer10.raycastTarget = true
		arg_4_0._clickLayer1 = gohelper.getClick(var_4_3)
		arg_4_0._clickLayer10 = gohelper.getClick(var_4_4)

		arg_4_0._clickLayer1:AddClickListener(arg_4_0._onClickAddLayer1, arg_4_0)
		arg_4_0._clickLayer10:AddClickListener(arg_4_0._onClickAddLayer10, arg_4_0)
		recthelper.setAnchor(arg_4_0._textAddLayer1.transform, 100, 25)
		recthelper.setAnchor(arg_4_0._textAddLayer10.transform, 100, -10)
	end

	if arg_4_0._textAddLayer1 then
		gohelper.setActive(arg_4_0._textAddLayer1.gameObject, arg_4_0._canShowLayer)
		gohelper.setActive(arg_4_0._textAddLayer10.gameObject, arg_4_0._canShowLayer)
	end
end

function var_0_0._onClickAddLayer1(arg_5_0)
	local var_5_0 = SkillEditorBuffSelectModel.instance.attacker
	local var_5_1 = arg_5_0:_getEntityBuffMO(var_5_0, arg_5_0._mo.co.id)

	var_5_1.layer = var_5_1.layer and var_5_1.layer + 1 or 1

	FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, var_5_0.id, FightEnum.EffectType.BUFFUPDATE, arg_5_0._mo.co.id, var_5_1.uid, 0)
	FightController.instance:dispatchEvent(FightEvent.SkillEditorRefreshBuff, arg_5_0._mo.co.id)
end

function var_0_0._onClickAddLayer10(arg_6_0)
	local var_6_0 = SkillEditorBuffSelectModel.instance.attacker
	local var_6_1 = arg_6_0:_getEntityBuffMO(var_6_0, arg_6_0._mo.co.id)

	var_6_1.layer = var_6_1.layer and var_6_1.layer + 10 or 10

	FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, var_6_0.id, FightEnum.EffectType.BUFFUPDATE, arg_6_0._mo.co.id, var_6_1.uid, 0)
	FightController.instance:dispatchEvent(FightEvent.SkillEditorRefreshBuff, arg_6_0._mo.co.id)
end

function var_0_0._onClickThis(arg_7_0)
	local var_7_0 = SkillEditorBuffSelectModel.instance.attacker
	local var_7_1 = arg_7_0._mo.co
	local var_7_2 = arg_7_0:_getEntityBuffMO(var_7_0, var_7_1.id)

	if var_7_2 == nil then
		local var_7_3 = FightDef_pb.BuffInfo()

		var_7_3.buffId = var_7_1.id
		var_7_3.duration = 1
		var_7_3.count = 1
		var_7_3.uid = SkillEditorBuffSelectView.genBuffUid()

		local var_7_4 = FightBuffInfoData.New(var_7_3, var_7_0.id)

		var_7_0:getMO():addBuff(var_7_4)
		var_7_0.buff:addBuff(var_7_4)

		if SkillEditorBuffSelectView._show_frame then
			FightController.instance:dispatchEvent(FightEvent.OnEditorPlayBuffStart)
		end

		FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, var_7_0.id, FightEnum.EffectType.BUFFADD, var_7_1.id, var_7_4.uid)
	else
		var_7_0:getMO():delBuff(var_7_2.uid)
		var_7_0.buff:delBuff(var_7_2.uid)
		FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, var_7_0.id, FightEnum.EffectType.BUFFDEL, var_7_1.id, var_7_2.uid)
	end

	if var_7_1.typeId == 5001 then
		var_7_0.nameUI:setShield(math.floor(var_7_0.nameUI:getHp() * 0.1 + 0.5))
	end

	FightController.instance:dispatchEvent(FightEvent.SkillEditorRefreshBuff, var_7_1.id)
	arg_7_0:onUpdateMO(arg_7_0._mo)
end

function var_0_0._getEntityBuffMO(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1:getMO():getBuffDic()

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		if iter_8_1.buffId == arg_8_2 then
			return iter_8_1
		end
	end

	return nil
end

return var_0_0

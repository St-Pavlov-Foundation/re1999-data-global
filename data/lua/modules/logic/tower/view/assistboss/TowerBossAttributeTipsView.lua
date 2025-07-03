module("modules.logic.tower.view.assistboss.TowerBossAttributeTipsView", package.seeall)

local var_0_0 = class("TowerBossAttributeTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.gotipitem = gohelper.findChild(arg_1_0.viewGO, "mask/root/scrollview/viewport/content/tipitem")

	gohelper.setActive(arg_1_0.gotipitem, false)

	arg_1_0.items = {}

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
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	arg_5_0:refreshParam()
	arg_5_0:refreshView()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:refreshParam()
	arg_6_0:refreshView()
end

function var_0_0.refreshParam(arg_7_0)
	arg_7_0.bossId = arg_7_0.viewParam.bossId
	arg_7_0.isFromHeroGroup = arg_7_0.viewParam.isFromHeroGroup
	arg_7_0.bossMo = TowerAssistBossModel.instance:getById(arg_7_0.bossId)
	arg_7_0.config = TowerConfig.instance:getAssistBossConfig(arg_7_0.bossId)
end

function var_0_0.refreshView(arg_8_0)
	arg_8_0:refreshAttr()
end

function var_0_0.refreshAttr(arg_9_0)
	local var_9_0 = 0
	local var_9_1 = arg_9_0.bossMo and arg_9_0.bossMo.trialLevel > 0 and arg_9_0.bossMo.trialLevel or arg_9_0.bossMo and arg_9_0.bossMo.level or 1
	local var_9_2 = TowerConfig.instance:getHeroGroupAddAttr(arg_9_0.bossId, var_9_0, var_9_1)
	local var_9_3 = math.max(#var_9_2, #arg_9_0.items)

	for iter_9_0 = 1, var_9_3 do
		local var_9_4 = arg_9_0:getAttrItem(iter_9_0)

		arg_9_0:updateAttrItem(var_9_4, var_9_2[iter_9_0])
	end
end

function var_0_0.getAttrItem(arg_10_0, arg_10_1)
	if not arg_10_0.items[arg_10_1] then
		local var_10_0 = arg_10_0:getUserDataTb_()

		var_10_0.go = gohelper.cloneInPlace(arg_10_0.gotipitem)
		var_10_0.imgIcon = gohelper.findChildImage(var_10_0.go, "icon")
		var_10_0.txtName = gohelper.findChildTextMesh(var_10_0.go, "name")
		var_10_0.txtNum = gohelper.findChildTextMesh(var_10_0.go, "num")
		var_10_0.txtAdd = gohelper.findChildTextMesh(var_10_0.go, "add")
		arg_10_0.items[arg_10_1] = var_10_0
	end

	return arg_10_0.items[arg_10_1]
end

function var_0_0.updateAttrItem(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_2 then
		gohelper.setActive(arg_11_1.go, false)

		return
	end

	gohelper.setActive(arg_11_1.go, true)

	local var_11_0 = HeroConfig.instance:getHeroAttributeCO(arg_11_2.key)

	arg_11_1.txtName.text = var_11_0.name

	if arg_11_2.val then
		if arg_11_2.upAttr then
			arg_11_1.txtNum.text = string.format("%s%%", arg_11_2.val * 0.1)
		else
			arg_11_1.txtNum.text = string.format("%s", arg_11_2.val)
		end
	else
		arg_11_1.txtNum.text = ""
	end

	arg_11_1.txtAdd.text = string.format("+%s%%", arg_11_2.add * 0.1)

	UISpriteSetMgr.instance:setCommonSprite(arg_11_1.imgIcon, string.format("icon_att_%s", arg_11_2.key))
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0

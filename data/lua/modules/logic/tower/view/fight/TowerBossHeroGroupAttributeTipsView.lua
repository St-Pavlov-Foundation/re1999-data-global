module("modules.logic.tower.view.fight.TowerBossHeroGroupAttributeTipsView", package.seeall)

local var_0_0 = class("TowerBossHeroGroupAttributeTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.gotipitem = gohelper.findChild(arg_1_0.viewGO, "mask/root/scrollview/viewport/content/tipitem")

	gohelper.setActive(arg_1_0.gotipitem, false)

	arg_1_0.items = {}
	arg_1_0.txtTeamLev = gohelper.findChildTextMesh(arg_1_0.viewGO, "title/txt_Lv/num")
	arg_1_0._btnClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "title/Click")
	arg_1_0.goSmallTips = gohelper.findChild(arg_1_0.viewGO, "#go_SmallTips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnClick, arg_2_0.onBtnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0._btnClick)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onBtnClick(arg_5_0)
	arg_5_0._isSmallTipsShow = not arg_5_0._isSmallTipsShow

	gohelper.setActive(arg_5_0.goSmallTips, arg_5_0._isSmallTipsShow)
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:refreshParam()
	arg_6_0:refreshView()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:refreshParam()
	arg_7_0:refreshView()
end

function var_0_0.refreshParam(arg_8_0)
	arg_8_0.bossId = arg_8_0.viewParam.bossId
	arg_8_0.bossMo = TowerAssistBossModel.instance:getById(arg_8_0.bossId)
	arg_8_0.config = TowerConfig.instance:getAssistBossConfig(arg_8_0.bossId)
end

function var_0_0.refreshView(arg_9_0)
	arg_9_0:refreshAttr()
end

function var_0_0.refreshAttr(arg_10_0)
	local var_10_0 = HeroSingleGroupModel.instance:getTeamLevel()

	arg_10_0.txtTeamLev.text = HeroConfig.instance:getCommonLevelDisplay(var_10_0)

	local var_10_1 = arg_10_0.bossMo and arg_10_0.bossMo.trialLevel > 0 and arg_10_0.bossMo.trialLevel or arg_10_0.bossMo and arg_10_0.bossMo.level or 1
	local var_10_2 = TowerConfig.instance:getHeroGroupAddAttr(arg_10_0.bossId, var_10_0, var_10_1)
	local var_10_3 = math.max(#var_10_2, #arg_10_0.items)

	for iter_10_0 = 1, var_10_3 do
		local var_10_4 = arg_10_0:getAttrItem(iter_10_0)

		arg_10_0:updateAttrItem(var_10_4, var_10_2[iter_10_0])
	end
end

function var_0_0.getAttrItem(arg_11_0, arg_11_1)
	if not arg_11_0.items[arg_11_1] then
		local var_11_0 = arg_11_0:getUserDataTb_()

		var_11_0.go = gohelper.cloneInPlace(arg_11_0.gotipitem)
		var_11_0.imgIcon = gohelper.findChildImage(var_11_0.go, "icon")
		var_11_0.txtName = gohelper.findChildTextMesh(var_11_0.go, "name")
		var_11_0.txtNum = gohelper.findChildTextMesh(var_11_0.go, "num")
		var_11_0.txtAdd = gohelper.findChildTextMesh(var_11_0.go, "add")
		arg_11_0.items[arg_11_1] = var_11_0
	end

	return arg_11_0.items[arg_11_1]
end

function var_0_0.updateAttrItem(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_2 then
		gohelper.setActive(arg_12_1.go, false)

		return
	end

	gohelper.setActive(arg_12_1.go, true)

	local var_12_0 = HeroConfig.instance:getHeroAttributeCO(arg_12_2.key)

	arg_12_1.txtName.text = var_12_0.name

	local var_12_1 = arg_12_2.val or 0

	if arg_12_2.upAttr then
		arg_12_1.txtNum.text = string.format("%s%%", var_12_1 * 0.1)
	else
		arg_12_1.txtNum.text = string.format("%s", var_12_1)
	end

	arg_12_1.txtAdd.text = string.format("+%s%%", arg_12_2.add * 0.1)

	UISpriteSetMgr.instance:setCommonSprite(arg_12_1.imgIcon, string.format("icon_att_%s", arg_12_2.key))
end

function var_0_0.onClose(arg_13_0)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0

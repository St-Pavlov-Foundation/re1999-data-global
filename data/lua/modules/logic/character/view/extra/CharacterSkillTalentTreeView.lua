module("modules.logic.character.view.extra.CharacterSkillTalentTreeView", package.seeall)

local var_0_0 = class("CharacterSkillTalentTreeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "talentTree/talenttreeitem/#go_select")
	arg_1_0._godark = gohelper.findChild(arg_1_0.viewGO, "talentTree/talenttreeitem/#go_dark")
	arg_1_0._imagedarkIcon = gohelper.findChildImage(arg_1_0.viewGO, "talentTree/talenttreeitem/#go_dark/#image_darkIcon")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "talentTree/talenttreeitem/#go_lock")
	arg_1_0._gocanlvup = gohelper.findChild(arg_1_0.viewGO, "talentTree/talenttreeitem/#go_canlvup")
	arg_1_0._gomaxEffect = gohelper.findChild(arg_1_0.viewGO, "talentTree/talenttreeitem/#go_canlvup/#go_maxEffect")
	arg_1_0._imagecanupicon = gohelper.findChildImage(arg_1_0.viewGO, "talentTree/talenttreeitem/#go_canlvup/#image_icon")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "talentTree/talenttreeitem/#btn_click")
	arg_1_0._gotreeType1 = gohelper.findChild(arg_1_0.viewGO, "talentTree/#go_treeType1")
	arg_1_0._gotreeType2 = gohelper.findChild(arg_1_0.viewGO, "talentTree/#go_treeType2")
	arg_1_0._gotreeType3 = gohelper.findChild(arg_1_0.viewGO, "talentTree/#go_treeType3")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onChoiceHero3124TalentTreeReply, arg_2_0._onChoiceHero3124TalentTreeReply, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onResetHero3124TalentTreeReply, arg_2_0._onResetHero3124TalentTreeReply, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onCancelHero3124TalentTreeReply, arg_2_0._onCancelHero3124TalentTreeReply, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onClickTalentTreeNode, arg_2_0._onClickTalentTreeNode, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onCloseSkillTalentTipView, arg_2_0._onCloseSkillTalentTipView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onChoiceHero3124TalentTreeReply, arg_3_0._onChoiceHero3124TalentTreeReply, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onResetHero3124TalentTreeReply, arg_3_0._onResetHero3124TalentTreeReply, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onCancelHero3124TalentTreeReply, arg_3_0._onCancelHero3124TalentTreeReply, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onClickTalentTreeNode, arg_3_0._onClickTalentTreeNode, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onCloseSkillTalentTipView, arg_3_0._onCloseSkillTalentTipView, arg_3_0)
end

function var_0_0._onChoiceHero3124TalentTreeReply(arg_4_0)
	arg_4_0:_refreshView()
end

function var_0_0._onCancelHero3124TalentTreeReply(arg_5_0)
	arg_5_0:_refreshView()
end

function var_0_0._onResetHero3124TalentTreeReply(arg_6_0)
	arg_6_0:_refreshView()
end

function var_0_0._onClickTalentTreeNode(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:_cancelAllSelectNodesEffect()

	local var_7_0 = arg_7_0.skillTalentMo:getLightOrCancelNodes(arg_7_1, arg_7_2)

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		arg_7_0:_getNodeItem(iter_7_1.co.sub, iter_7_1.co.level):showSelectEffect(true)
		table.insert(arg_7_0._lightNodes, {
			sub = iter_7_1.co.sub,
			level = iter_7_1.co.level
		})
	end

	if arg_7_0._clickNodeItem then
		arg_7_0._clickNodeItem:showSelect(false)
	end

	arg_7_0._clickNodeItem = arg_7_0:_getNodeItem(arg_7_1, arg_7_2)

	arg_7_0._clickNodeItem:showSelect(true)
end

function var_0_0._onCloseSkillTalentTipView(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0._clickNodeItem then
		arg_8_0._clickNodeItem:showSelect(false)
	end

	arg_8_0:_cancelAllSelectNodesEffect()
end

function var_0_0._cancelAllSelectNodesEffect(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._lightNodes) do
		arg_9_0:_getNodeItem(iter_9_1.sub, iter_9_1.level):showSelectEffect(false)
	end

	arg_9_0._lightNodes = {}
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0.treeNodeItems = arg_10_0:getUserDataTb_()
	arg_10_0._lightNodes = {}
	arg_10_0._gonodeItem = gohelper.findChild(arg_10_0.viewGO, "talentTree/talenttreeitem")

	gohelper.setActive(arg_10_0._gonodeItem, false)
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0.heroMo = arg_12_0.viewParam
	arg_12_0.skillTalentMo = arg_12_0.heroMo.extraMo:getSkillTalentMo()

	arg_12_0:_refreshSubTree()
	arg_12_0:_refreshView()
end

function var_0_0.onClose(arg_13_0)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

function var_0_0._refreshSubTree(arg_15_0)
	for iter_15_0 = 1, CharacterExtraEnum.TalentSkillSubCount do
		local var_15_0 = arg_15_0.skillTalentMo:getTreeMosBySub(iter_15_0):getTreeMoList()

		for iter_15_1, iter_15_2 in ipairs(var_15_0) do
			arg_15_0:_getNodeItem(iter_15_0, iter_15_2.level):onUpdateMO(iter_15_2)
		end

		arg_15_0:_getTreeItem(iter_15_0).txtName.text = luaLang("characterskilltalent_sub_" .. iter_15_0)
	end
end

function var_0_0._refreshView(arg_16_0)
	if arg_16_0.treeNodeItems then
		for iter_16_0, iter_16_1 in pairs(arg_16_0.treeNodeItems) do
			if iter_16_1.nodeItems then
				for iter_16_2, iter_16_3 in ipairs(iter_16_1.nodeItems) do
					iter_16_3:refreshStatus()
				end
			end

			local var_16_0 = arg_16_0.skillTalentMo:getTreeLightCount(iter_16_0)

			gohelper.setActive(iter_16_1.golv2, var_16_0 == 1 or var_16_0 == 2)

			if iter_16_1.golv3 then
				for iter_16_4, iter_16_5 in ipairs(iter_16_1.golv3) do
					gohelper.setActive(iter_16_5, var_16_0 == 3)
				end
			end

			local var_16_1 = arg_16_0.skillTalentMo:getSubIconPath(iter_16_0)

			UISpriteSetMgr.instance:setUiCharacterSprite(iter_16_1.imageicon, var_16_1)
		end
	end
end

function var_0_0._getNodeItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0:_getTreeItem(arg_17_1)
	local var_17_1 = var_17_0.nodeItems

	if not var_17_1 then
		var_17_1 = arg_17_0:getUserDataTb_()

		for iter_17_0 = 1, CharacterExtraEnum.TalentSkillTreeNodeCount do
			local var_17_2 = gohelper.findChild(var_17_0.treeGo, "go_talentitem" .. iter_17_0)
			local var_17_3 = gohelper.clone(arg_17_0._gonodeItem, var_17_2, iter_17_0)

			gohelper.setActive(var_17_3, true)
			recthelper.setAnchor(var_17_3.transform, 0, 0)

			local var_17_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_17_3, CharacterSkillTalentTreeNode)
			local var_17_5 = string.format("go_lineContent/go_line%d", iter_17_0)
			local var_17_6 = gohelper.findChild(var_17_0.treeGo, var_17_5)

			var_17_4:setLineGo(var_17_6)

			local var_17_7 = gohelper.findChild(var_17_6, "#lv3")

			if var_17_0.golv3 and var_17_7 then
				table.insert(var_17_0.golv3, var_17_7)
			end

			table.insert(var_17_1, var_17_4)
		end

		var_17_0.nodeItems = var_17_1
	end

	return var_17_1[arg_17_2]
end

function var_0_0._getTreeItem(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.treeNodeItems[arg_18_1]

	if not var_18_0 then
		var_18_0 = arg_18_0:getUserDataTb_()

		local var_18_1 = arg_18_0["_gotreeType" .. arg_18_1]

		var_18_0.treeGo = var_18_1

		local var_18_2 = gohelper.findChild(var_18_1, "treeInfo")

		var_18_0.txtName = gohelper.findChildText(var_18_2, "txt_typeName")
		var_18_0.treeInfo = var_18_2
		var_18_0.imageicon = gohelper.findChildImage(var_18_2, "icon")
		var_18_0.golv2 = gohelper.findChild(var_18_2, "#lv2")
		var_18_0.golv3 = arg_18_0:getUserDataTb_()

		table.insert(var_18_0.golv3, gohelper.findChild(var_18_2, "#lv3"))

		arg_18_0.treeNodeItems[arg_18_1] = var_18_0
	end

	return var_18_0
end

return var_0_0

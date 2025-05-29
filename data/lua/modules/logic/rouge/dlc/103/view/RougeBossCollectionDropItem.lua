module("modules.logic.rouge.dlc.103.view.RougeBossCollectionDropItem", package.seeall)

local var_0_0 = class("RougeBossCollectionDropItem", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.parent = arg_1_2

	arg_1_0:_editableInitView()
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0.animator = arg_2_0.go:GetComponent(gohelper.Type_Animator)
	arg_2_0._goselect = gohelper.findChild(arg_2_0.go, "#go_select")
	arg_2_0._goenchantlist = gohelper.findChild(arg_2_0.go, "#go_enchantlist")
	arg_2_0._gohole = gohelper.findChild(arg_2_0.go, "#go_enchantlist/#go_hole")
	arg_2_0._gridLayout = gohelper.findChild(arg_2_0.go, "Grid")
	arg_2_0._gogriditem = gohelper.findChild(arg_2_0.go, "Grid/#go_grid")
	arg_2_0._simagecollection = gohelper.findChildSingleImage(arg_2_0.go, "#simage_collection")
	arg_2_0._txtname = gohelper.findChildText(arg_2_0.go, "#txt_name")
	arg_2_0._scrollreward = gohelper.findChild(arg_2_0.go, "scroll_desc"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_2_0._godescContent = gohelper.findChild(arg_2_0.go, "scroll_desc/Viewport/#go_descContent")
	arg_2_0._scrollbossattr = gohelper.findChildScrollRect(arg_2_0.go, "#scroll_bossattr")
	arg_2_0._gobossDescContent = gohelper.findChild(arg_2_0.go, "#scroll_bossattr/Viewport/#go_bossDescContent")
	arg_2_0._txtbossattrdesc = gohelper.findChildText(arg_2_0.go, "#scroll_bossattr/Viewport/#go_bossDescContent/go_bossattritem/#txt_desc")
	arg_2_0._gotags = gohelper.findChild(arg_2_0.go, "tagcontent/tags")
	arg_2_0._gotagitem = gohelper.findChild(arg_2_0.go, "tagcontent/tags/#go_tagitem")
	arg_2_0._gotips = gohelper.findChild(arg_2_0.go, "#go_tips")
	arg_2_0._gotipscontent = gohelper.findChild(arg_2_0.go, "#go_tips/#go_tipscontent")
	arg_2_0._gotipitem = gohelper.findChild(arg_2_0.go, "#go_tips/#go_tipscontent/#txt_tagitem")
	arg_2_0._btnopentagtips = gohelper.findChildButtonWithAudio(arg_2_0.go, "tagcontent/#btn_opentagtips")
	arg_2_0._btnclosetagtips = gohelper.findChildButtonWithAudio(arg_2_0.go, "#go_tips/#btn_closetips")
	arg_2_0._btnfresh = gohelper.findChildButtonWithAudio(arg_2_0.go, "#scroll_bossattr/#btn_fresh")
	arg_2_0._gofreshicon_drak = gohelper.findChild(arg_2_0.go, "#scroll_bossattr/#btn_fresh/dark")
	arg_2_0._gofreshicon_light = gohelper.findChild(arg_2_0.go, "#scroll_bossattr/#btn_fresh/light")
	arg_2_0.holeGoList = arg_2_0:getUserDataTb_()

	table.insert(arg_2_0.holeGoList, arg_2_0._gohole)

	arg_2_0.gridList = arg_2_0:getUserDataTb_()
	arg_2_0._itemInstTab = arg_2_0:getUserDataTb_()
	arg_2_0.click = gohelper.getClickWithDefaultAudio(arg_2_0.go)

	arg_2_0.click:AddClickListener(arg_2_0.onClickSelf, arg_2_0)
	arg_2_0._btnopentagtips:AddClickListener(arg_2_0._opentagtipsOnClick, arg_2_0)
	arg_2_0._btnclosetagtips:AddClickListener(arg_2_0._closetagtipsOnClick, arg_2_0)
	arg_2_0._btnfresh:AddClickListener(arg_2_0._btnfreshOnClick, arg_2_0)

	arg_2_0._bossviewportclick = gohelper.findChildClickWithDefaultAudio(arg_2_0.go, "#scroll_bossattr/Viewport")

	arg_2_0._bossviewportclick:AddClickListener(arg_2_0.onClickSelf, arg_2_0)

	arg_2_0._bossdescclick = gohelper.getClickWithDefaultAudio(arg_2_0._txtbossattrdesc.gameObject)

	arg_2_0._bossdescclick:AddClickListener(arg_2_0.onClickSelf, arg_2_0)
	arg_2_0:addEventCb(RougeMapController.instance, RougeMapEvent.onSelectDropChange, arg_2_0.onSelectDropChange, arg_2_0)
	arg_2_0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, arg_2_0._onSwitchCollectionInfoType, arg_2_0)
	arg_2_0:addEventCb(RougeController.instance, RougeEvent.ShowMonsterRuleDesc, arg_2_0.switchShowMonsterRuleDesc, arg_2_0)
end

function var_0_0.onClickSelf(arg_3_0)
	arg_3_0.parent:selectPos(arg_3_0.index)
	arg_3_0:refreshSelect()
end

function var_0_0._opentagtipsOnClick(arg_4_0)
	gohelper.setActive(arg_4_0._gotips, true)
	RougeCollectionHelper.loadCollectionAndEnchantTagNames(arg_4_0.collectionId, nil, arg_4_0._gotipscontent, arg_4_0._gotipitem)
end

function var_0_0._closetagtipsOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._gotips, false)
end

function var_0_0._btnfreshOnClick(arg_6_0)
	if not arg_6_0._canFresh then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.RefreshRougeBossCollection)
	arg_6_0.animator:Play("open", 0, 0)

	local var_6_0 = RougeModel.instance:getSeason()

	RougeRpc.instance:sendRougeRefreshMonsterRuleRequest(var_6_0, arg_6_0.index)
end

function var_0_0.onSelectDropChange(arg_7_0)
	arg_7_0.select = arg_7_0.parent:isSelect(arg_7_0.index)

	arg_7_0:refreshSelect()
end

function var_0_0.setParentScroll(arg_8_0, arg_8_1)
	arg_8_0._scrollreward.parentGameObject = arg_8_1
end

function var_0_0.update(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	arg_9_0.select = false
	arg_9_0.index = arg_9_1
	arg_9_0.collectionId = tonumber(arg_9_2)
	arg_9_0.collectionCo = RougeCollectionConfig.instance:getCollectionCfg(arg_9_0.collectionId)
	arg_9_0.monsterRuleId = tonumber(arg_9_3)
	arg_9_0.monsterRuleCo = RougeDLCConfig103.instance:getMonsterRuleConfig(arg_9_0.monsterRuleId)
	arg_9_0.isShowMonsterRule = arg_9_4

	arg_9_0:refreshHole()
	RougeCollectionHelper.loadShapeGrid(arg_9_0.collectionId, arg_9_0._gridLayout, arg_9_0._gogriditem, arg_9_0.gridList)
	RougeCollectionHelper.loadCollectionTags(arg_9_0.collectionId, arg_9_0._gotags, arg_9_0._gotagitem)
	arg_9_0._simagecollection:LoadImage(RougeCollectionHelper.getCollectionIconUrl(arg_9_0.collectionId))

	arg_9_0._txtname.text = RougeCollectionConfig.instance:getCollectionName(arg_9_0.collectionId)

	arg_9_0:refreshCollectionDesc()
	arg_9_0:refreshSelect()
end

function var_0_0.refreshHole(arg_10_0)
	local var_10_0 = arg_10_0.collectionCo.holeNum

	gohelper.setActive(arg_10_0._goenchantlist, var_10_0 > 0)

	if var_10_0 > 1 then
		for iter_10_0 = 1, var_10_0 do
			local var_10_1 = arg_10_0.holeGoList[iter_10_0]

			if not var_10_1 then
				var_10_1 = gohelper.cloneInPlace(arg_10_0._gohole)

				table.insert(arg_10_0.holeGoList, var_10_1)
			end

			gohelper.setActive(var_10_1, true)
		end

		for iter_10_1 = var_10_0 + 1, #arg_10_0.holeGoList do
			gohelper.setActive(arg_10_0.holeGoList[iter_10_1], false)
		end
	end
end

function var_0_0.refreshEffectDesc(arg_11_0)
	arg_11_0._allClicks = arg_11_0._allClicks or arg_11_0:getUserDataTb_()
	arg_11_0._clickLen = arg_11_0._clickLen or 0

	for iter_11_0 = 1, arg_11_0._clickLen do
		arg_11_0._allClicks[iter_11_0]:RemoveClickListener()
	end

	arg_11_0._clickLen = 0

	RougeCollectionDescHelper.setCollectionDescInfos2(arg_11_0.collectionId, nil, arg_11_0._godescContent, arg_11_0._itemInstTab)

	local var_11_0 = arg_11_0._scrollreward.gameObject:GetComponentsInChildren(typeof(SLFramework.UGUI.UIClickListener), true)

	arg_11_0._clickLen = var_11_0.Length

	for iter_11_1 = 0, arg_11_0._clickLen - 1 do
		arg_11_0._allClicks[iter_11_1 + 1] = var_11_0[iter_11_1]

		arg_11_0._allClicks[iter_11_1 + 1]:AddClickListener(arg_11_0.onClickSelf, arg_11_0)
		gohelper.addUIClickAudio(arg_11_0._allClicks[iter_11_1 + 1].gameObject)
	end
end

function var_0_0.refreshBossAttrDesc(arg_12_0)
	local var_12_0 = arg_12_0.monsterRuleCo and arg_12_0.monsterRuleCo.desc or ""

	arg_12_0._txtbossattrdesc.text = SkillHelper.addLink(var_12_0)

	SkillHelper.addHyperLinkClick(arg_12_0._txtbossattrdesc)
end

function var_0_0.refreshFreshBtn(arg_13_0)
	local var_13_0 = RougeMapModel.instance:getMonsterRuleRemainCanFreshNum()

	arg_13_0._canFresh = var_13_0 and var_13_0 > 0

	gohelper.setActive(arg_13_0._gofreshicon_light, arg_13_0._canFresh)
	gohelper.setActive(arg_13_0._gofreshicon_drak, not arg_13_0._canFresh)
end

function var_0_0.refreshCollectionDesc(arg_14_0)
	gohelper.setActive(arg_14_0._scrollreward.gameObject, not arg_14_0.isShowMonsterRule)
	gohelper.setActive(arg_14_0._scrollbossattr.gameObject, arg_14_0.isShowMonsterRule)

	if arg_14_0.isShowMonsterRule then
		arg_14_0:refreshBossAttrDesc()
		arg_14_0:refreshFreshBtn()
	else
		arg_14_0:refreshEffectDesc()
	end
end

function var_0_0.switchShowMonsterRuleDesc(arg_15_0, arg_15_1)
	arg_15_0.animator:Play("open", 0, 0)

	arg_15_0.isShowMonsterRule = arg_15_1

	arg_15_0:refreshCollectionDesc()
end

function var_0_0.refreshSelect(arg_16_0)
	gohelper.setActive(arg_16_0._goselect, arg_16_0.select)
end

function var_0_0._onSwitchCollectionInfoType(arg_17_0)
	arg_17_0:refreshEffectDesc()
end

function var_0_0.hide(arg_18_0)
	gohelper.setActive(arg_18_0.go, false)
end

function var_0_0.show(arg_19_0)
	if arg_19_0.go.activeInHierarchy then
		return
	end

	arg_19_0.animator:Play("open", 0, 0)
	gohelper.setActive(arg_19_0.go, true)
end

function var_0_0.onClose(arg_20_0)
	arg_20_0.animator:Play(arg_20_0.select and "close" or "normal", 0, 0)
end

function var_0_0.destroy(arg_21_0)
	if arg_21_0._clickLen then
		for iter_21_0 = 1, arg_21_0._clickLen do
			arg_21_0._allClicks[iter_21_0]:RemoveClickListener()
		end
	end

	arg_21_0.click:RemoveClickListener()
	arg_21_0._btnopentagtips:RemoveClickListener()
	arg_21_0._btnclosetagtips:RemoveClickListener()
	arg_21_0._btnfresh:RemoveClickListener()
	arg_21_0._bossdescclick:RemoveClickListener()
	arg_21_0._bossviewportclick:RemoveClickListener()
	arg_21_0._simagecollection:UnLoadImage()
	arg_21_0:__onDispose()
end

return var_0_0

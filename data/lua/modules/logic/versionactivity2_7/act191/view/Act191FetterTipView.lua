module("modules.logic.versionactivity2_7.act191.view.Act191FetterTipView", package.seeall)

local var_0_0 = class("Act191FetterTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.viewGO, "title/#txt_Name")
	arg_1_0._imageIcon = gohelper.findChildImage(arg_1_0.viewGO, "title/#image_Icon")
	arg_1_0._scrollDetails = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_Details")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "#scroll_Details/Viewport/Content/#txt_Desc")
	arg_1_0._goFetterDesc = gohelper.findChild(arg_1_0.viewGO, "#scroll_Details/Viewport/Content/#go_FetterDesc")
	arg_1_0._scrollHeros = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_Heros")
	arg_1_0._goHeroItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_Heros/Viewport/Content/#go_HeroItem")

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

function var_0_0.onClickModalMask(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_panel_close)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	SkillHelper.addHyperLinkClick(arg_5_0._txtDesc, Activity191Helper.clickHyperLinkSkill)
end

function var_0_0.onOpen(arg_6_0)
	Act191StatController.instance:onViewOpen(arg_6_0.viewName)

	arg_6_0.activeLvl = 0
	arg_6_0.tag = arg_6_0.viewParam.tag
	arg_6_0.fetterCoList = Activity191Config.instance:getRelationCoList(arg_6_0.tag)

	local var_6_0 = arg_6_0.fetterCoList[0]

	arg_6_0._txtName.text = var_6_0.name

	Activity191Helper.setFetterIcon(arg_6_0._imageIcon, var_6_0.icon)

	local var_6_1

	if arg_6_0.viewParam.isFight then
		arg_6_0.activeCnt = arg_6_0.viewParam.count or 0

		for iter_6_0, iter_6_1 in ipairs(arg_6_0.fetterCoList) do
			local var_6_2 = gohelper.cloneInPlace(arg_6_0._goFetterDesc)
			local var_6_3 = gohelper.findChildText(var_6_2, "")

			SkillHelper.addHyperLinkClick(var_6_3, Activity191Helper.clickHyperLinkSkill)

			local var_6_4 = SkillHelper.addLink(iter_6_1.levelDesc)
			local var_6_5 = Activity191Helper.buildDesc(var_6_4, Activity191Enum.HyperLinkPattern.SkillDesc)

			if arg_6_0.activeCnt >= iter_6_1.activeNum then
				if arg_6_0.activeLvl < iter_6_1.level then
					arg_6_0.activeLvl = iter_6_1.level
				end

				var_6_3.text = GameUtil.getSubPlaceholderLuaLang(luaLang("Act191FetterTipView_goFetterDesc_Empty1"), {
					arg_6_0.activeCnt,
					iter_6_1.activeNum,
					var_6_5
				})
			else
				var_6_3.text = GameUtil.getSubPlaceholderLuaLang(luaLang("Act191FetterTipView_goFetterDesc_Empty2"), {
					arg_6_0.activeCnt,
					iter_6_1.activeNum,
					var_6_5
				})
			end

			arg_6_0:_fixHeight(var_6_3)
		end

		gohelper.setActive(arg_6_0._goFetterDesc, false)
		gohelper.setActive(arg_6_0._scrollHeros, false)
		recthelper.setHeight(arg_6_0._scrollDetails.gameObject.transform, 647)

		var_6_1 = string.delBracketContent(arg_6_0.fetterCoList[arg_6_0.activeLvl].desc)
		var_6_1 = SkillHelper.addLink(var_6_1)
		var_6_1 = Activity191Helper.buildDesc(var_6_1, Activity191Enum.HyperLinkPattern.SkillDesc)
		arg_6_0._txtDesc.text = var_6_1

		return
	end

	arg_6_0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

	if arg_6_0.viewParam.isPreview then
		for iter_6_2, iter_6_3 in ipairs(arg_6_0.fetterCoList) do
			local var_6_6 = gohelper.cloneInPlace(arg_6_0._goFetterDesc)
			local var_6_7 = gohelper.findChildText(var_6_6, "")

			SkillHelper.addHyperLinkClick(var_6_7, Activity191Helper.clickHyperLinkSkill)

			local var_6_8 = SkillHelper.addLink(iter_6_3.levelDesc)
			local var_6_9 = Activity191Helper.buildDesc(var_6_8, Activity191Enum.HyperLinkPattern.SkillDesc)

			var_6_7.text = string.format(luaLang("Act191FetterTipView_goFetterDesc"), iter_6_3.activeNum, var_6_9)

			arg_6_0:_fixHeight(var_6_7)
		end

		arg_6_0.fetterHeroList = Activity191Config.instance:getFetterHeroList(arg_6_0.tag)
		var_6_1 = string.delBracketContent(arg_6_0.fetterCoList[0].desc)
	elseif arg_6_0.viewParam.isEnemy then
		local var_6_10 = arg_6_0.gameInfo:getNodeDetailMo().matchInfo

		arg_6_0.fetterHeroList = var_6_10:getFetterHeroList(arg_6_0.tag)
		arg_6_0.activeCnt = var_6_10:getTeamFetterCntDic()[arg_6_0.tag] or 0

		for iter_6_4, iter_6_5 in ipairs(arg_6_0.fetterCoList) do
			local var_6_11 = gohelper.cloneInPlace(arg_6_0._goFetterDesc)
			local var_6_12 = gohelper.findChildText(var_6_11, "")

			SkillHelper.addHyperLinkClick(var_6_12, Activity191Helper.clickHyperLinkSkill)

			local var_6_13 = SkillHelper.addLink(iter_6_5.levelDesc)
			local var_6_14 = Activity191Helper.buildDesc(var_6_13, Activity191Enum.HyperLinkPattern.SkillDesc)

			if arg_6_0.activeCnt >= iter_6_5.activeNum then
				if arg_6_0.activeLvl < iter_6_5.level then
					arg_6_0.activeLvl = iter_6_5.level
				end

				var_6_12.text = GameUtil.getSubPlaceholderLuaLang(luaLang("Act191FetterTipView_goFetterDesc_Empty1"), {
					arg_6_0.activeCnt,
					iter_6_5.activeNum,
					var_6_14
				})
			else
				var_6_12.text = GameUtil.getSubPlaceholderLuaLang(luaLang("Act191FetterTipView_goFetterDesc_Empty2"), {
					arg_6_0.activeCnt,
					iter_6_5.activeNum,
					var_6_14
				})
			end

			arg_6_0:_fixHeight(var_6_12)
		end

		var_6_1 = string.delBracketContent(arg_6_0.fetterCoList[0].desc)
	else
		arg_6_0.fetterHeroList = arg_6_0.gameInfo:getFetterHeroList(arg_6_0.tag)
		arg_6_0.activeCnt = arg_6_0.gameInfo:getTeamFetterCntDic()[arg_6_0.tag] or 0

		for iter_6_6, iter_6_7 in ipairs(arg_6_0.fetterCoList) do
			local var_6_15 = gohelper.cloneInPlace(arg_6_0._goFetterDesc)
			local var_6_16 = gohelper.findChildText(var_6_15, "")

			SkillHelper.addHyperLinkClick(var_6_16, Activity191Helper.clickHyperLinkSkill)

			local var_6_17 = SkillHelper.addLink(iter_6_7.levelDesc)
			local var_6_18 = Activity191Helper.buildDesc(var_6_17, Activity191Enum.HyperLinkPattern.SkillDesc)

			if arg_6_0.activeCnt >= iter_6_7.activeNum then
				if arg_6_0.activeLvl < iter_6_7.level then
					arg_6_0.activeLvl = iter_6_7.level
				end

				var_6_16.text = GameUtil.getSubPlaceholderLuaLang(luaLang("Act191FetterTipView_goFetterDesc_Empty1"), {
					arg_6_0.activeCnt,
					iter_6_7.activeNum,
					var_6_18
				})
			else
				var_6_16.text = GameUtil.getSubPlaceholderLuaLang(luaLang("Act191FetterTipView_goFetterDesc_Empty2"), {
					arg_6_0.activeCnt,
					iter_6_7.activeNum,
					var_6_18
				})
			end

			arg_6_0:_fixHeight(var_6_16)
		end

		local var_6_19 = arg_6_0.fetterCoList[arg_6_0.activeLvl]
		local var_6_20 = var_6_19.effects
		local var_6_21 = false

		if not string.nilorempty(var_6_20) then
			local var_6_22 = string.splitToNumber(arg_6_0.fetterCoList[arg_6_0.activeLvl].effects, "|")

			for iter_6_8, iter_6_9 in ipairs(var_6_22) do
				local var_6_23 = arg_6_0.gameInfo:getAct191Effect(iter_6_9)

				if var_6_23 and (not var_6_23["end"] or iter_6_8 == #var_6_22) then
					var_6_1 = GameUtil.getSubPlaceholderLuaLangOneParam(var_6_19.desc, string.format("%d/%d", var_6_23.count, var_6_23.needCount))
					var_6_21 = true

					break
				end
			end
		end

		if not var_6_21 then
			var_6_1 = string.delBracketContent(var_6_19.desc)
		end
	end

	local var_6_24 = SkillHelper.addLink(var_6_1)
	local var_6_25 = Activity191Helper.buildDesc(var_6_24, Activity191Enum.HyperLinkPattern.SkillDesc)

	arg_6_0._txtDesc.text = var_6_25

	gohelper.setActive(arg_6_0._goFetterDesc, false)
	arg_6_0:refreshHeroHead()
end

function var_0_0.onClose(arg_7_0)
	local var_7_0 = arg_7_0.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(arg_7_0.viewName, var_7_0, arg_7_0.fetterCoList[0].name)
end

function var_0_0.refreshHeroHead(arg_8_0)
	local var_8_0 = {
		noClick = true,
		noFetter = true
	}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.fetterHeroList) do
		local var_8_1 = gohelper.cloneInPlace(arg_8_0._goHeroItem)
		local var_8_2 = arg_8_0:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, var_8_1)
		local var_8_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_2, Act191HeroHeadItem, var_8_0)

		var_8_3:setData(nil, iter_8_1.config.id)

		if iter_8_1.inBag == 0 then
			var_8_3:setNotOwn()
		elseif iter_8_1.inBag == 2 then
			var_8_3:setActivation(true)
		end
	end

	arg_8_0._scrollHeros.horizontalNormalizedPosition = 0

	gohelper.setActive(arg_8_0._goHeroItem, false)
end

function var_0_0._fixHeight(arg_9_0, arg_9_1)
	MonoHelper.addNoUpdateLuaComOnceToGo(arg_9_1.gameObject, FixTmpBreakLine):refreshTmpContent(arg_9_1)
end

return var_0_0

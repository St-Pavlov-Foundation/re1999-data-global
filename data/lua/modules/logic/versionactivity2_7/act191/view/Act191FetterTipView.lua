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

function var_0_0.onClickModalMask(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_panel_close)
	arg_2_0:closeThis()
end

function var_0_0._editableInitView(arg_3_0)
	arg_3_0.actId = Activity191Model.instance:getCurActId()

	SkillHelper.addHyperLinkClick(arg_3_0._txtDesc, Activity191Helper.clickHyperLinkSkill)
end

function var_0_0.onOpen(arg_4_0)
	Act191StatController.instance:onViewOpen(arg_4_0.viewName)

	arg_4_0.activeLvl = 0
	arg_4_0.tag = arg_4_0.viewParam.tag
	arg_4_0.fetterCoList = Activity191Config.instance:getRelationCoList(arg_4_0.tag)

	local var_4_0 = arg_4_0.fetterCoList[0]

	arg_4_0._txtName.text = var_4_0.name

	Activity191Helper.setFetterIcon(arg_4_0._imageIcon, var_4_0.icon)

	local var_4_1

	if arg_4_0.viewParam.isFight then
		arg_4_0.activeCnt = arg_4_0.viewParam.count or 0

		for iter_4_0, iter_4_1 in ipairs(arg_4_0.fetterCoList) do
			local var_4_2 = gohelper.cloneInPlace(arg_4_0._goFetterDesc)
			local var_4_3 = gohelper.findChildText(var_4_2, "")

			SkillHelper.addHyperLinkClick(var_4_3, Activity191Helper.clickHyperLinkSkill)

			local var_4_4 = SkillHelper.addLink(iter_4_1.levelDesc)
			local var_4_5 = Activity191Helper.buildDesc(var_4_4, Activity191Enum.HyperLinkPattern.SkillDesc)

			if arg_4_0.activeCnt >= iter_4_1.activeNum then
				if arg_4_0.activeLvl < iter_4_1.level then
					arg_4_0.activeLvl = iter_4_1.level
				end

				var_4_3.text = GameUtil.getSubPlaceholderLuaLang(luaLang("Act191FetterTipView_goFetterDesc_Empty1"), {
					arg_4_0.activeCnt,
					iter_4_1.activeNum,
					var_4_5
				})
			else
				var_4_3.text = GameUtil.getSubPlaceholderLuaLang(luaLang("Act191FetterTipView_goFetterDesc_Empty2"), {
					arg_4_0.activeCnt,
					iter_4_1.activeNum,
					var_4_5
				})
			end

			arg_4_0:_fixHeight(var_4_3)
		end

		gohelper.setActive(arg_4_0._goFetterDesc, false)
		gohelper.setActive(arg_4_0._scrollHeros, false)
		recthelper.setHeight(arg_4_0._scrollDetails.gameObject.transform, 647)

		var_4_1 = string.delBracketContent(arg_4_0.fetterCoList[arg_4_0.activeLvl].desc)
		var_4_1 = SkillHelper.addLink(var_4_1)
		var_4_1 = Activity191Helper.buildDesc(var_4_1, Activity191Enum.HyperLinkPattern.SkillDesc)
		arg_4_0._txtDesc.text = var_4_1

		return
	end

	arg_4_0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

	if arg_4_0.viewParam.isPreview then
		for iter_4_2, iter_4_3 in ipairs(arg_4_0.fetterCoList) do
			local var_4_6 = gohelper.cloneInPlace(arg_4_0._goFetterDesc)
			local var_4_7 = gohelper.findChildText(var_4_6, "")

			SkillHelper.addHyperLinkClick(var_4_7, Activity191Helper.clickHyperLinkSkill)

			local var_4_8 = SkillHelper.addLink(iter_4_3.levelDesc)
			local var_4_9 = Activity191Helper.buildDesc(var_4_8, Activity191Enum.HyperLinkPattern.SkillDesc)

			var_4_7.text = string.format(luaLang("Act191FetterTipView_goFetterDesc"), iter_4_3.activeNum, var_4_9)

			arg_4_0:_fixHeight(var_4_7)
		end

		arg_4_0.fetterHeroList = Activity191Config.instance:getFetterHeroList(arg_4_0.tag, arg_4_0.actId)
		var_4_1 = string.delBracketContent(arg_4_0.fetterCoList[0].desc)
	elseif arg_4_0.viewParam.isEnemy then
		local var_4_10 = arg_4_0.gameInfo:getNodeDetailMo().matchInfo

		arg_4_0.fetterHeroList = var_4_10:getFetterHeroList(arg_4_0.tag)
		arg_4_0.activeCnt = var_4_10:getTeamFetterCntDic()[arg_4_0.tag] or 0

		for iter_4_4, iter_4_5 in ipairs(arg_4_0.fetterCoList) do
			local var_4_11 = gohelper.cloneInPlace(arg_4_0._goFetterDesc)
			local var_4_12 = gohelper.findChildText(var_4_11, "")

			SkillHelper.addHyperLinkClick(var_4_12, Activity191Helper.clickHyperLinkSkill)

			local var_4_13 = SkillHelper.addLink(iter_4_5.levelDesc)
			local var_4_14 = Activity191Helper.buildDesc(var_4_13, Activity191Enum.HyperLinkPattern.SkillDesc)

			if arg_4_0.activeCnt >= iter_4_5.activeNum then
				if arg_4_0.activeLvl < iter_4_5.level then
					arg_4_0.activeLvl = iter_4_5.level
				end

				var_4_12.text = GameUtil.getSubPlaceholderLuaLang(luaLang("Act191FetterTipView_goFetterDesc_Empty1"), {
					arg_4_0.activeCnt,
					iter_4_5.activeNum,
					var_4_14
				})
			else
				var_4_12.text = GameUtil.getSubPlaceholderLuaLang(luaLang("Act191FetterTipView_goFetterDesc_Empty2"), {
					arg_4_0.activeCnt,
					iter_4_5.activeNum,
					var_4_14
				})
			end

			arg_4_0:_fixHeight(var_4_12)
		end

		var_4_1 = string.delBracketContent(arg_4_0.fetterCoList[0].desc)
	else
		arg_4_0.fetterHeroList = arg_4_0.gameInfo:getFetterHeroList(arg_4_0.tag)
		arg_4_0.activeCnt = arg_4_0.gameInfo:getTeamFetterCntDic()[arg_4_0.tag] or 0

		for iter_4_6, iter_4_7 in ipairs(arg_4_0.fetterCoList) do
			local var_4_15 = gohelper.cloneInPlace(arg_4_0._goFetterDesc)
			local var_4_16 = gohelper.findChildText(var_4_15, "")

			SkillHelper.addHyperLinkClick(var_4_16, Activity191Helper.clickHyperLinkSkill)

			local var_4_17 = SkillHelper.addLink(iter_4_7.levelDesc)
			local var_4_18 = Activity191Helper.buildDesc(var_4_17, Activity191Enum.HyperLinkPattern.SkillDesc)

			if arg_4_0.activeCnt >= iter_4_7.activeNum then
				if arg_4_0.activeLvl < iter_4_7.level then
					arg_4_0.activeLvl = iter_4_7.level
				end

				var_4_16.text = GameUtil.getSubPlaceholderLuaLang(luaLang("Act191FetterTipView_goFetterDesc_Empty1"), {
					arg_4_0.activeCnt,
					iter_4_7.activeNum,
					var_4_18
				})
			else
				var_4_16.text = GameUtil.getSubPlaceholderLuaLang(luaLang("Act191FetterTipView_goFetterDesc_Empty2"), {
					arg_4_0.activeCnt,
					iter_4_7.activeNum,
					var_4_18
				})
			end

			arg_4_0:_fixHeight(var_4_16)
		end

		local var_4_19 = arg_4_0.fetterCoList[arg_4_0.activeLvl]

		var_4_1 = arg_4_0.gameInfo:getRelationDesc(var_4_19)
	end

	local var_4_20 = SkillHelper.addLink(var_4_1)
	local var_4_21 = Activity191Helper.buildDesc(var_4_20, Activity191Enum.HyperLinkPattern.SkillDesc)

	arg_4_0._txtDesc.text = var_4_21

	gohelper.setActive(arg_4_0._goFetterDesc, false)
	arg_4_0:refreshHeroHead()
end

function var_0_0.onClose(arg_5_0)
	local var_5_0 = arg_5_0.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(arg_5_0.viewName, var_5_0, arg_5_0.fetterCoList[0].name)
end

function var_0_0.refreshHeroHead(arg_6_0)
	local var_6_0 = {
		noClick = true,
		noFetter = true
	}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.fetterHeroList) do
		local var_6_1 = gohelper.cloneInPlace(arg_6_0._goHeroItem)
		local var_6_2 = arg_6_0:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, var_6_1)
		local var_6_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_2, Act191HeroHeadItem, var_6_0)

		var_6_3:setData(nil, iter_6_1.config.id)

		if iter_6_1.inBag == 0 then
			var_6_3:setNotOwn()
		elseif iter_6_1.inBag == 2 then
			var_6_3:setActivation(true)
		end
	end

	arg_6_0._scrollHeros.horizontalNormalizedPosition = 0

	gohelper.setActive(arg_6_0._goHeroItem, false)
end

function var_0_0._fixHeight(arg_7_0, arg_7_1)
	MonoHelper.addNoUpdateLuaComOnceToGo(arg_7_1.gameObject, FixTmpBreakLine):refreshTmpContent(arg_7_1)
end

return var_0_0

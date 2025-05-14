module("modules.logic.dungeon.view.chapter.DungeonLevelItem", package.seeall)

local var_0_0 = class("DungeonLevelItem", BaseChildView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txt1 = gohelper.findChildText(arg_1_0.viewGO, "#txt_1")
	arg_1_0._txtglow = gohelper.findChildText(arg_1_0.viewGO, "#txt_glow")
	arg_1_0._txtsection = gohelper.findChildText(arg_1_0.viewGO, "#txt_section")
	arg_1_0._goendline = gohelper.findChild(arg_1_0.viewGO, "#go_endline")
	arg_1_0._gostartline = gohelper.findChild(arg_1_0.viewGO, "#go_startline")
	arg_1_0._gostar = gohelper.findChild(arg_1_0.viewGO, "#txt_section/star/#go_star")

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
	local var_4_0 = gohelper.findChild(arg_4_0.viewGO, "raycast")

	arg_4_0._click = gohelper.getClick(var_4_0)
	arg_4_0._animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_4_0:_initStar()
	arg_4_0:onUpdateParam()
end

function var_0_0.hideBeforeAnimation(arg_5_0)
	if arg_5_0._animator then
		arg_5_0._animator:Play(UIAnimationName.Open, 0, 0)

		arg_5_0._animator.speed = 0

		arg_5_0._animator:Update(0)
	end
end

function var_0_0.playAnimation(arg_6_0)
	if arg_6_0._animator then
		arg_6_0._animator:Play(UIAnimationName.Open, 0, 0)

		arg_6_0._animator.speed = 1
	end
end

function var_0_0._playIsNewAnimation(arg_7_0)
	local var_7_0 = DungeonModel.instance:getLastEpisodeShowData()
	local var_7_1 = var_7_0 and var_7_0.id == arg_7_0._config.id

	if arg_7_0._animator then
		arg_7_0._animator:SetBool("isNew", var_7_1)
	end
end

function var_0_0._initStar(arg_8_0)
	local var_8_0 = gohelper.findChild(arg_8_0.viewGO, "#txt_section/star")

	gohelper.setActive(var_8_0, true)
	gohelper.setActive(arg_8_0._gostar, true)

	arg_8_0._starImgList = arg_8_0:getUserDataTb_()

	local var_8_1 = arg_8_0._gostar.transform
	local var_8_2 = var_8_1.childCount

	for iter_8_0 = 1, var_8_2 do
		local var_8_3 = var_8_1:GetChild(iter_8_0 - 1):GetComponent(gohelper.Type_Image)

		table.insert(arg_8_0._starImgList, var_8_3)
	end
end

function var_0_0.getLineStartTrans(arg_9_0)
	return arg_9_0._gostartline.transform
end

function var_0_0.getLineEndTrans(arg_10_0)
	return arg_10_0._goendline.transform
end

function var_0_0.getTrans(arg_11_0)
	return arg_11_0.viewGO.transform
end

function var_0_0.showStatus(arg_12_0)
	local var_12_0 = arg_12_0._config.id
	local var_12_1 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon)
	local var_12_2 = var_12_0 and DungeonModel.instance:hasPassLevelAndStory(var_12_0)
	local var_12_3 = DungeonConfig.instance:getEpisodeAdvancedConditionText(var_12_0)
	local var_12_4 = arg_12_0._info
	local var_12_5 = DungeonConfig.instance:getHardEpisode(arg_12_0._config.id)
	local var_12_6 = var_12_5 and DungeonModel.instance:getEpisodeInfo(var_12_5.id)
	local var_12_7 = arg_12_0._starImgList[3]
	local var_12_8 = arg_12_0._starImgList[2]

	arg_12_0:_setStar(arg_12_0._starImgList[1], var_12_4.star >= DungeonEnum.StarType.Normal and var_12_2)
	gohelper.setActive(var_12_8.gameObject, false)
	gohelper.setActive(var_12_7.gameObject, false)

	if not string.nilorempty(var_12_3) then
		arg_12_0:_setStar(var_12_8, var_12_4.star >= DungeonEnum.StarType.Advanced and var_12_2)
		gohelper.setActive(var_12_8.gameObject, true)

		if var_12_6 and var_12_4.star >= DungeonEnum.StarType.Advanced and var_12_1 and var_12_2 then
			arg_12_0:_setStar(var_12_7, var_12_6.star >= DungeonEnum.StarType.Normal and var_12_2)
			gohelper.setActive(var_12_7.gameObject, true)
		end
	end
end

function var_0_0._setStar(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_2 and "star_liang" or "star_an"

	UISpriteSetMgr.instance:setUiFBSprite(arg_13_1, var_13_0)

	if arg_13_2 then
		gohelper.setAsLastSibling(arg_13_1.gameObject)
	end
end

function var_0_0.setGray(arg_14_0, arg_14_1)
	if arg_14_1 and not arg_14_0._graphicsContainer then
		arg_14_0._graphicsContainer = arg_14_0:getUserDataTb_()
		arg_14_0._graphicsContainer.images = arg_14_0.viewGO:GetComponentsInChildren(gohelper.Type_Image, true)
		arg_14_0._graphicsContainer.tmps = arg_14_0.viewGO:GetComponentsInChildren(gohelper.Type_TextMesh, true)
	end

	if arg_14_0._graphicsContainer then
		local var_14_0 = arg_14_0._graphicsContainer.images:GetEnumerator()

		while var_14_0:MoveNext() do
			ZProj.UGUIHelper.SetGrayscale(var_14_0.Current.gameObject, arg_14_1)
		end

		local var_14_1 = arg_14_0._graphicsContainer.tmps:GetEnumerator()

		while var_14_1:MoveNext() do
			ZProj.UGUIHelper.SetGrayscale(var_14_1.Current.gameObject, arg_14_1)
		end
	end
end

function var_0_0.showEpisodeName(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_3.text = DungeonController.getEpisodeName(arg_15_0)
end

function var_0_0.hasUnlockContent(arg_16_0)
	local var_16_0 = OpenConfig.instance:getOpenShowInEpisode(arg_16_0._config.id)
	local var_16_1 = DungeonConfig.instance:getUnlockEpisodeList(arg_16_0._config.id)
	local var_16_2 = OpenConfig.instance:getOpenGroupShowInEpisode(arg_16_0._config.id)
	local var_16_3 = (var_16_0 or var_16_1 or var_16_2) and not DungeonModel.instance:hasPassLevelAndStory(arg_16_0._config.id)
	local var_16_4 = arg_16_0._config.unlockEpisode > 0 and not DungeonModel.instance:hasPassLevelAndStory(arg_16_0._config.unlockEpisode)

	return var_16_3 or var_16_4
end

function var_0_0.addUnlockItem(arg_17_0, arg_17_1)
	local var_17_0 = MonoHelper.addLuaComOnceToGo(arg_17_1, DungeonChapterUnlockItem, arg_17_0._config)
end

function var_0_0.onUpdateParam(arg_18_0)
	arg_18_0._config = arg_18_0.viewParam[1]
	arg_18_0._info = arg_18_0.viewParam[2]
	arg_18_0._chapterIndex = arg_18_0.viewParam[3]
	arg_18_0._levelIndex = arg_18_0.viewParam[4]

	var_0_0.showEpisodeName(arg_18_0._config, arg_18_0._chapterIndex, arg_18_0._levelIndex, arg_18_0._txtsection)

	arg_18_0._txt1.text = arg_18_0._config.name
	arg_18_0._txtglow.text = arg_18_0._config.name

	arg_18_0:showStatus()

	if DungeonModel.isBattleEpisode(arg_18_0._config) then
		local var_18_0 = string.splitToNumber(arg_18_0._config.icon, "#")
		local var_18_1 = var_18_0[1]
		local var_18_2 = var_18_0[2]
		local var_18_3
		local var_18_4

		if var_18_1 and var_18_2 then
			local var_18_5, var_18_6 = ItemModel.instance:getItemConfigAndIcon(var_18_1, var_18_2)
		end
	end

	local var_18_7 = DungeonModel.instance:isCanChallenge(arg_18_0._config)

	arg_18_0:setGray(not var_18_7)
	arg_18_0:_playIsNewAnimation()
end

function var_0_0._onClickHandler(arg_19_0)
	if not DungeonModel.isBattleEpisode(arg_19_0._config) then
		local var_19_0 = DungeonModel.instance:getCantChallengeToast(arg_19_0._config)

		if var_19_0 then
			GameFacade.showToast(ToastEnum.CantChallengeToast, var_19_0)

			return
		end
	end

	DungeonController.instance:enterLevelView(arg_19_0.viewParam)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickFocusEpisode, arg_19_0)
end

function var_0_0.onOpen(arg_20_0)
	arg_20_0._click:AddClickListener(arg_20_0._onClickHandler, arg_20_0)
end

function var_0_0.onClose(arg_21_0)
	arg_21_0._click:RemoveClickListener()
end

function var_0_0.onDestroyView(arg_22_0)
	return
end

return var_0_0

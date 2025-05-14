module("modules.logic.rouge.view.RougeReviewItem", package.seeall)

local var_0_0 = class("RougeReviewItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goUnlocked = gohelper.findChild(arg_1_0.viewGO, "#go_Unlocked")
	arg_1_0._simageItemPic = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Unlocked/#simage_ItemPic")
	arg_1_0._gonew = gohelper.findChild(arg_1_0.viewGO, "#go_Unlocked/#go_new")
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.viewGO, "#go_Unlocked/#txt_Name")
	arg_1_0._txtNameEn = gohelper.findChildText(arg_1_0.viewGO, "#go_Unlocked/#txt_Name/#txt_NameEn")
	arg_1_0._btnPlay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Unlocked/#btn_Play")
	arg_1_0._goLocked = gohelper.findChild(arg_1_0.viewGO, "#go_Locked")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_Locked/#txt_desc")
	arg_1_0._txtUnknown = gohelper.findChildText(arg_1_0.viewGO, "#go_Locked/#txt_Unknown")
	arg_1_0._goLine = gohelper.findChild(arg_1_0.viewGO, "#go_Line")
	arg_1_0._goLine1 = gohelper.findChild(arg_1_0.viewGO, "#go_Line/#go_Line1")
	arg_1_0._goLine2 = gohelper.findChild(arg_1_0.viewGO, "#go_Line/#go_Line2")
	arg_1_0._goLine3 = gohelper.findChild(arg_1_0.viewGO, "#go_Line/#go_Line3")
	arg_1_0._goLine4 = gohelper.findChild(arg_1_0.viewGO, "#go_Line/#go_Line4")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnPlay:AddClickListener(arg_2_0._btnPlayOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnPlay:RemoveClickListener()
end

function var_0_0._btnPlayOnClick(arg_4_0)
	local var_4_0 = {}

	if not string.nilorempty(arg_4_0._config.levelIdDict) then
		local var_4_1 = string.split(arg_4_0._config.levelIdDict, "|")

		for iter_4_0, iter_4_1 in ipairs(var_4_1) do
			local var_4_2 = string.splitToNumber(iter_4_1, "#")

			var_4_0[var_4_2[1]] = var_4_2[2]
		end
	end

	local var_4_3 = {
		levelIdDict = var_4_0
	}

	var_4_3.isReplay = true

	StoryController.instance:playStories(arg_4_0._mo.storyIdList, var_4_3)

	if arg_4_0._showNewFlag then
		local var_4_4 = RougeOutsideModel.instance:season()

		RougeOutsideRpc.instance:sendRougeMarkNewReddotRequest(var_4_4, RougeEnum.FavoriteType.Story, arg_4_0._mo.config.id, arg_4_0._updateNewFlag, arg_4_0)
	end
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.setIndex(arg_8_0, arg_8_1)
	arg_8_0._index = arg_8_1
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	arg_9_0._mo = arg_9_1
	arg_9_0._config = arg_9_1.config
	arg_9_0._isEnd = arg_9_2
	arg_9_0._reviewView = arg_9_3
	arg_9_0._path = arg_9_5

	arg_9_0:_updateInfo()
	arg_9_0:_initNodes(arg_9_4)
	arg_9_0:_updateNewFlag()
end

function var_0_0._updateNewFlag(arg_10_0)
	arg_10_0._showNewFlag = RougeFavoriteModel.instance:getReddot(RougeEnum.FavoriteType.Story, arg_10_0._mo.config.id) ~= nil

	gohelper.setActive(arg_10_0._gonew, arg_10_0._showNewFlag)
end

function var_0_0._initNodes(arg_11_0, arg_11_1)
	if not arg_11_0._isUnlock then
		return
	end

	if not arg_11_1 or #arg_11_1 <= 1 then
		local var_11_0 = not arg_11_0._isEnd

		gohelper.setActive(arg_11_0._goLine1, var_11_0)

		if arg_11_1 and var_11_0 then
			for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
				arg_11_0:_showNodeText(iter_11_1, arg_11_0._goLine1, iter_11_0)
			end
		end

		return
	end

	local var_11_1 = arg_11_0["_goLine" .. #arg_11_1]

	gohelper.setActive(var_11_1, true)

	for iter_11_2, iter_11_3 in ipairs(arg_11_1) do
		local var_11_2 = gohelper.findChild(var_11_1, "#go_End" .. iter_11_2)
		local var_11_3 = arg_11_0._reviewView:getResInst(arg_11_0._path, var_11_2, "item" .. iter_11_3.config.id)
		local var_11_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_3, var_0_0)

		var_11_4._showLock = true

		var_11_4:onUpdateMO(iter_11_3, true)
		arg_11_0:_showNodeText(iter_11_3, var_11_1, iter_11_2)
	end
end

function var_0_0._showNodeText(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_1 and arg_12_0:_isUnlockStory(arg_12_1) then
		gohelper.findChildText(arg_12_2, string.format("image_Line/image_Line%s/#txt_Descr%s", arg_12_3, arg_12_3)).text = arg_12_1.config.desc
	end
end

function var_0_0._updateInfo(arg_13_0)
	arg_13_0._isUnlock = arg_13_0:_isUnlockStory(arg_13_0._mo)

	gohelper.setActive(arg_13_0._goUnlocked, arg_13_0._isUnlock)

	local var_13_0 = arg_13_0._showLock or arg_13_0._index == 1

	gohelper.setActive(arg_13_0._goLocked, not arg_13_0._isUnlock and var_13_0)

	if not arg_13_0._isUnlock then
		return
	end

	arg_13_0._txtName.text = arg_13_0._config.name
	arg_13_0._txtNameEn.text = arg_13_0._config.nameEn

	arg_13_0._simageItemPic:LoadImage(arg_13_0._config.image)
end

function var_0_0.isUnlock(arg_14_0)
	return arg_14_0._isUnlock
end

function var_0_0.setMaxUnlockStateId(arg_15_0, arg_15_1)
	arg_15_0._maxUnlockStateId = arg_15_1
end

function var_0_0._isUnlockStory(arg_16_0, arg_16_1)
	if arg_16_0._maxUnlockStateId and arg_16_0._maxUnlockStateId >= arg_16_1.config.stageId then
		return true
	end

	local var_16_0 = arg_16_1.storyIdList
	local var_16_1 = var_16_0[#var_16_0]

	return RougeOutsideModel.instance:storyIsPass(var_16_1)
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0

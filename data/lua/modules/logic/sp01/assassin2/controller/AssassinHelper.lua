module("modules.logic.sp01.assassin2.controller.AssassinHelper", package.seeall)

local var_0_0 = _M

function var_0_0.setQuestTypeIcon(arg_1_0, arg_1_1)
	if gohelper.isNil(arg_1_1) then
		logError("AssassinHelper.setQuestTypeIcon error, imgComp is nil")

		return
	end

	local var_1_0 = AssassinConfig.instance:getQuestTypeIcon(arg_1_0)

	UISpriteSetMgr.instance:setSp01AssassinSprite(arg_1_1, var_1_0)
end

function var_0_0.setAssassinItemIcon(arg_2_0, arg_2_1)
	if gohelper.isNil(arg_2_1) then
		logError("AssassinHelper.setAssassinItemIcon error, imgComp is nil")

		return
	end

	local var_2_0 = AssassinConfig.instance:getAssassinItemIcon(arg_2_0)

	UISpriteSetMgr.instance:setSp01AssassinSprite(arg_2_1, var_2_0)
end

function var_0_0.setAssassinActIcon(arg_3_0, arg_3_1)
	if gohelper.isNil(arg_3_1) then
		return
	end

	local var_3_0 = AssassinConfig.instance:getAssassinActIcon(arg_3_0)

	if string.nilorempty(var_3_0) then
		gohelper.setActive(arg_3_1, false)
	else
		UISpriteSetMgr.instance:setSp01AssassinSprite(arg_3_1, var_3_0)
		gohelper.setActive(arg_3_1, true)
	end
end

function var_0_0.setAssassinSkillIcon(arg_4_0, arg_4_1)
	if gohelper.isNil(arg_4_1) then
		logError("AssassinHelper.setAssassinSkillIcon error, imgComp is nil")

		return
	end

	local var_4_0 = AssassinConfig.instance:getAssassinSkillIcon(arg_4_0)

	UISpriteSetMgr.instance:setSp01AssassinSprite(arg_4_1, var_4_0)
end

function var_0_0.lockScreen(arg_5_0, arg_5_1)
	if arg_5_1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock(arg_5_0)
	else
		UIBlockMgr.instance:endBlock(arg_5_0)
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function var_0_0.getPlayerCacheDataKey(arg_6_0, arg_6_1)
	return string.format("%s_%s", arg_6_0, arg_6_1)
end

function var_0_0.formatLv(arg_7_0)
	return string.format("Lv.%s", arg_7_0)
end

function var_0_0.getLibraryTopTitleByActId(arg_8_0)
	local var_8_0 = ActivityConfig.instance:getActivityCo(arg_8_0)

	return var_8_0 and var_8_0.name
end

function var_0_0.setLibraryIcon(arg_9_0, arg_9_1)
	if gohelper.isNil(arg_9_1) then
		logError("图片组件不可为空")

		return
	end

	local var_9_0 = AssassinConfig.instance:getLibrarConfig(arg_9_0)
	local var_9_1 = var_9_0 and var_9_0.res or ""
	local var_9_2 = "library/" .. var_9_1

	arg_9_1:LoadImage(ResUrl.getSp01AssassinSingleBg(var_9_2))
end

function var_0_0.setLibraryToastIcon(arg_10_0, arg_10_1)
	if gohelper.isNil(arg_10_1) then
		logError("图片组件不可为空")

		return
	end

	local var_10_0 = AssassinConfig.instance:getLibrarConfig(arg_10_0)
	local var_10_1 = var_10_0 and var_10_0.toastIcon or ""
	local var_10_2 = "library/assassinlibrarytoast_pic/" .. var_10_1

	arg_10_1:LoadImage(ResUrl.getSp01AssassinSingleBg(var_10_2))
end

function var_0_0.multipleKeys2OneKey(...)
	local var_11_0 = {
		...
	}

	return table.concat(var_11_0, "_")
end

return var_0_0

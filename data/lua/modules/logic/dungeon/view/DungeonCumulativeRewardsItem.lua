module("modules.logic.dungeon.view.DungeonCumulativeRewardsItem", package.seeall)

local var_0_0 = class("DungeonCumulativeRewardsItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "#go_rewards")
	arg_1_0._goimportant = gohelper.findChild(arg_1_0.viewGO, "#go_rewards/#go_important")
	arg_1_0._simageimportantbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_rewards/#go_important/#simage_importantbg")
	arg_1_0._txtpointname = gohelper.findChildText(arg_1_0.viewGO, "#go_rewards/#go_important/#txt_pointname")
	arg_1_0._gofinishline = gohelper.findChild(arg_1_0.viewGO, "#go_rewards/#go_important/#txt_pointname/#go_finishline")
	arg_1_0._gounfinishline = gohelper.findChild(arg_1_0.viewGO, "#go_rewards/#go_important/#txt_pointname/#go_unfinishline")
	arg_1_0._gorewardtemplate = gohelper.findChild(arg_1_0.viewGO, "#go_rewards/#go_reward_template")
	arg_1_0._imagestatus = gohelper.findChildImage(arg_1_0.viewGO, "#go_rewards/#image_status")

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

function var_0_0.ctor(arg_4_0, arg_4_1)
	arg_4_0._chapterId = arg_4_1[1]
	arg_4_0._pointRewardCfg = arg_4_1[2]
	arg_4_0._isRightDisplay = arg_4_1[3]
	arg_4_0.rewardId = arg_4_0._pointRewardCfg.id
	arg_4_0.curPointValue = arg_4_0._pointRewardCfg.rewardPointNum
	arg_4_0.prevPosX = arg_4_1[4]
	arg_4_0.curPosX = arg_4_1[5]
	arg_4_0.prevPointValue = arg_4_1[6]
end

function var_0_0.createRewardUIs(arg_5_0)
	local var_5_0 = arg_5_0._pointRewardCfg
	local var_5_1 = string.split(var_5_0.reward, "|")

	arg_5_0._rewarditems = {}

	for iter_5_0 = 1, #var_5_1 do
		local var_5_2 = string.splitToNumber(var_5_1[iter_5_0], "#")
		local var_5_3 = arg_5_0:getUserDataTb_()
		local var_5_4 = gohelper.clone(arg_5_0._gorewardtemplate, arg_5_0._gorewards, "reward_" .. tostring(iter_5_0))

		var_5_3.imagebg = gohelper.findChildImage(var_5_4, "image_bg")
		var_5_3.imagecircle = gohelper.findChildImage(var_5_4, "image_circle")
		var_5_3.simagereward = gohelper.findChildSingleImage(var_5_4, "simage_reward")
		var_5_3.txtrewardcount = gohelper.findChildText(var_5_4, "txt_rewardcount")
		var_5_3.txtpointvalue = gohelper.findChildText(var_5_4, "txt_pointvalue")
		var_5_3.imagereward = var_5_3.simagereward:GetComponent(gohelper.Type_Image)
		var_5_3.btn = gohelper.findChildClick(var_5_4, "simage_reward")
		var_5_3.goalreadygot = gohelper.findChild(var_5_4, "go_hasget")

		var_5_3.btn:AddClickListener(arg_5_0.onClickItem, arg_5_0, var_5_3)

		var_5_3.go = var_5_4
		var_5_3.rewardCfg = var_5_2
		var_5_3.itemCfg, var_5_3.iconPath = ItemModel.instance:getItemConfigAndIcon(var_5_2[1], var_5_2[2])

		gohelper.setActive(var_5_3.go, true)
		UISpriteSetMgr.instance:setUiFBSprite(var_5_3.imagebg, "bg_pinjidi_" .. var_5_3.itemCfg.rare)
		UISpriteSetMgr.instance:setUiFBSprite(var_5_3.imagecircle, "bg_pinjidi_lanse_" .. var_5_3.itemCfg.rare)
		table.insert(arg_5_0._rewarditems, var_5_3)
	end
end

function var_0_0.refreshRewardItems(arg_6_0, arg_6_1)
	arg_6_0._pointRewardInfo = DungeonMapModel.instance:getRewardPointInfo(arg_6_0._chapterId)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._rewarditems) do
		arg_6_0:refreshRewardUIItem(iter_6_1, arg_6_0._pointRewardCfg, arg_6_1)
	end
end

local var_0_1 = Color.New(0.5, 0.5, 0.5, 1)
local var_0_2 = Color.New(1, 1, 1, 1)
local var_0_3 = Color.New(0.5, 0.5, 0.5, 1)
local var_0_4 = Color.New(1, 1, 1, 1)
local var_0_5 = Color.New(0.4, 0.3882353, 0.3843137, 1)
local var_0_6 = Color.New(0.6745098, 0.3254902, 0.1254902, 1)

function var_0_0.refreshRewardUIItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = tabletool.indexOf(arg_7_0._pointRewardInfo.hasGetPointRewardIds, arg_7_2.id)

	arg_7_1.simagereward:LoadImage(arg_7_1.iconPath)

	arg_7_1.txtrewardcount.text = string.format("<size=25>%s</size>%s", luaLang("multiple"), tostring(arg_7_1.rewardCfg[3]))
	arg_7_1.txtpointvalue.text = arg_7_2.rewardPointNum
	arg_7_1.txtpointvalue.color = var_7_0 and var_0_6 or var_0_5

	gohelper.setActive(arg_7_1.goalreadygot, var_7_0)

	if arg_7_3 then
		arg_7_1.goalreadygot:GetComponent(typeof(UnityEngine.Animator)):Play("go_hasget_in")
	end

	local var_7_1 = arg_7_1.go:GetComponent(typeof(UnityEngine.Animator))

	if var_7_0 then
		if not arg_7_3 then
			var_7_1:Play("dungeoncumulativerewardsitem_receiveenter")
		else
			var_7_1:Play("dungeoncumulativerewardsitem_received")
		end
	end
end

function var_0_0.onClickItem(arg_8_0, arg_8_1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	MaterialTipController.instance:showMaterialInfo(arg_8_1.rewardCfg[1], arg_8_1.rewardCfg[2])
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0:createRewardUIs()
	arg_9_0:refreshRewardItems()
	arg_9_0:_refreshStatus()
	arg_9_0._simageimportantbg:LoadImage(ResUrl.getDungeonIcon("bg_tishidiban"))
end

function var_0_0._refreshStatus(arg_10_0)
	local var_10_0 = arg_10_0._pointRewardInfo.rewardPoint >= arg_10_0.curPointValue

	if arg_10_0._pointRewardCfg.display > 0 then
		UISpriteSetMgr.instance:setUiFBSprite(arg_10_0._imagestatus, "bg_xingjidian_1" .. (var_10_0 and "" or "_dis"), true)
	else
		UISpriteSetMgr.instance:setUiFBSprite(arg_10_0._imagestatus, "bg_xingjidian" .. (var_10_0 and "" or "_dis"), true)
	end

	gohelper.setActive(arg_10_0._goimportant, arg_10_0._pointRewardCfg.display > 0)

	if arg_10_0._pointRewardCfg.unlockChapter > 0 then
		local var_10_1 = lua_chapter.configDict[arg_10_0._pointRewardCfg.unlockChapter]

		arg_10_0._txtpointname.text = string.format(luaLang("dungeonmapview_unlocktitle"), var_10_1.name)

		gohelper.setActive(arg_10_0._gofinishline, var_10_0)
		gohelper.setActive(arg_10_0._gounfinishline, not var_10_0)
	else
		gohelper.setActive(arg_10_0._txtpointname.gameObject, false)
	end

	gohelper.setActive(arg_10_0._simageimportantbg.gameObject, not arg_10_0._isRightDisplay)
end

function var_0_0._editableAddEvents(arg_11_0)
	return
end

function var_0_0._editableRemoveEvents(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0._rewarditems) do
		iter_13_1.btn:RemoveClickListener()
		iter_13_1.simagereward:UnLoadImage()
	end

	arg_13_0._simageimportantbg:UnLoadImage()
end

return var_0_0

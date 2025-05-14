module("modules.logic.seasonver.act166.view.Season166TeachView", package.seeall)

local var_0_0 = class("Season166TeachView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._btncloseReward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeReward")
	arg_1_0._goteachContent = gohelper.findChild(arg_1_0.viewGO, "#go_teachContent")
	arg_1_0._goteachItem = gohelper.findChild(arg_1_0.viewGO, "#go_teachContent/#go_teachItem")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_0.viewGO, "#go_rewardContent")
	arg_1_0._gorewardWindow = gohelper.findChild(arg_1_0.viewGO, "#go_rewardContent/#go_rewardWindow")
	arg_1_0._gorewardItem = gohelper.findChild(arg_1_0.viewGO, "#go_rewardContent/#go_rewardWindow/#go_rewardItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncloseReward:AddClickListener(arg_2_0._btncloseRewardOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncloseReward:RemoveClickListener()
end

function var_0_0._btncloseRewardOnClick(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.rewardWindowTab) do
		gohelper.setActive(iter_4_1.window, false)

		iter_4_1.isShow = false
	end
end

function var_0_0._btnRewardOnClick(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.rewardWindowTab) do
		if iter_5_0 == arg_5_1 then
			iter_5_1.isShow = not iter_5_1.isShow
		else
			iter_5_1.isShow = false
		end

		gohelper.setActive(iter_5_1.window, iter_5_1.isShow)
	end
end

function var_0_0._btnTeachItemOnClick(arg_6_0, arg_6_1)
	arg_6_0:_btncloseRewardOnClick()

	local var_6_0 = arg_6_0.Season166MO.teachInfoMap[arg_6_1.teachId]
	local var_6_1 = arg_6_0.Season166MO.teachInfoMap[arg_6_1.preTeachId]
	local var_6_2 = arg_6_1.preTeachId == 0 or arg_6_1.preTeachId > 0 and var_6_1 and var_6_1.passCount > 0

	if not var_6_0 or not var_6_2 then
		GameFacade.showToast(ToastEnum.Season166TeachLock)
	else
		local var_6_3 = arg_6_1.episodeId
		local var_6_4 = DungeonConfig.instance:getEpisodeCO(var_6_3)
		local var_6_5 = arg_6_1.teachId
		local var_6_6 = 0

		Season166TeachModel.instance:initTeachData(arg_6_0.actId, var_6_5)
		Season166Model.instance:setBattleContext(arg_6_0.actId, var_6_3, nil, var_6_6, nil, var_6_5)
		DungeonFightController.instance:enterSeasonFight(var_6_4.chapterId, var_6_3)
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0.teachItemTab = arg_7_0:getUserDataTb_()
	arg_7_0.rewardWindowTab = arg_7_0:getUserDataTb_()
	arg_7_0.localUnlockStateTab = arg_7_0:getUserDataTb_()

	gohelper.setActive(arg_7_0._goteachItem, false)
	gohelper.setActive(arg_7_0._gorewardWindow, false)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0.actId = arg_9_0.viewParam.actId

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Season166.play_ui_shiji_tv_noise)
	arg_9_0:createTeachItem()
	arg_9_0:createRewardItem()
	arg_9_0:refreshTeachItem()
end

function var_0_0.createTeachItem(arg_10_0)
	local var_10_0 = Season166Config.instance:getAllSeasonTeachCos()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_1 = arg_10_0.teachItemTab[iter_10_1.teachId]

		if not var_10_1 then
			var_10_1 = {
				config = iter_10_1,
				pos = gohelper.findChild(arg_10_0._goteachContent, "go_teachPos" .. iter_10_0)
			}
			var_10_1.item = gohelper.clone(arg_10_0._goteachItem, var_10_1.pos, "teachItem" .. iter_10_0)
			var_10_1.imageIndex = gohelper.findChildImage(var_10_1.item, "title/image_index")
			var_10_1.txtName = gohelper.findChildText(var_10_1.item, "title/txt_name")
			var_10_1.imageIcon = gohelper.findChildImage(var_10_1.item, "image_icon")
			var_10_1.txtDesc = gohelper.findChildText(var_10_1.item, "desc/txt_desc")
			var_10_1.goLock = gohelper.findChild(var_10_1.item, "go_lock")
			var_10_1.goFinish = gohelper.findChild(var_10_1.item, "go_finish")
			var_10_1.btnReward = gohelper.findChildButtonWithAudio(var_10_1.item, "btn_reward")
			var_10_1.btnClick = gohelper.findChildButtonWithAudio(var_10_1.item, "btn_click")

			var_10_1.btnReward:AddClickListener(arg_10_0._btnRewardOnClick, arg_10_0, var_10_1.config.teachId)
			var_10_1.btnClick:AddClickListener(arg_10_0._btnTeachItemOnClick, arg_10_0, var_10_1.config)

			var_10_1.anim = var_10_1.item:GetComponent(gohelper.Type_Animator)
			arg_10_0.teachItemTab[iter_10_1.teachId] = var_10_1
		end

		gohelper.setActive(var_10_1.item, true)
		UISpriteSetMgr.instance:setSeason166Sprite(var_10_1.imageIndex, "season_teach_num" .. iter_10_0, true)

		var_10_1.txtName.text = iter_10_1.name
		var_10_1.txtDesc.text = iter_10_1.desc
	end
end

function var_0_0.createRewardItem(arg_11_0)
	local var_11_0 = Season166Config.instance:getAllSeasonTeachCos()

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_1 = arg_11_0.rewardWindowTab[iter_11_1.teachId]

		if not var_11_1 then
			var_11_1 = {
				pos = gohelper.findChild(arg_11_0._gorewardContent, "go_rewardPos" .. iter_11_0)
			}
			var_11_1.window = gohelper.clone(arg_11_0._gorewardWindow, var_11_1.pos, "rewardWindow" .. iter_11_0)
			var_11_1.rewardItem = gohelper.findChild(var_11_1.window, "#go_rewardItem")
			var_11_1.isShow = false
			var_11_1.rewardList = arg_11_0:getUserDataTb_()
			arg_11_0.rewardWindowTab[iter_11_1.teachId] = var_11_1
		end

		gohelper.setActive(var_11_1.window, true)
		gohelper.setActive(var_11_1.rewardItem, false)

		local var_11_2 = string.split(iter_11_1.firstBonus, "|")

		for iter_11_2, iter_11_3 in ipairs(var_11_2) do
			local var_11_3 = var_11_1.rewardList[iter_11_2]

			if not var_11_3 then
				var_11_3 = {
					rewardItem = gohelper.clone(var_11_1.rewardItem, var_11_1.window, "rewardItem" .. iter_11_2)
				}
				var_11_3.itemPos = gohelper.findChild(var_11_3.rewardItem, "go_rewardItemPos")
				var_11_3.goGet = gohelper.findChild(var_11_3.rewardItem, "go_get")
				var_11_3.item = IconMgr.instance:getCommonPropItemIcon(var_11_3.itemPos)
				var_11_1.rewardList[iter_11_2] = var_11_3
			end

			gohelper.setActive(var_11_3.rewardItem, true)

			local var_11_4 = string.splitToNumber(iter_11_3, "#")

			var_11_3.item:setMOValue(var_11_4[1], var_11_4[2], var_11_4[3])
			var_11_3.item:setHideLvAndBreakFlag(true)
			var_11_3.item:hideEquipLvAndBreak(true)
			var_11_3.item:setCountFontSize(51)
		end

		for iter_11_4 = #var_11_2 + 1, #var_11_1.rewardList do
			gohelper.setActive(var_11_1.rewardList[iter_11_4].rewardItem, false)
		end
	end
end

function var_0_0.refreshTeachItem(arg_12_0)
	arg_12_0.Season166MO = Season166Model.instance:getActInfo(arg_12_0.actId)

	local var_12_0 = Season166Model.instance:getLocalUnlockState(Season166Enum.TeachLockSaveKey)

	for iter_12_0, iter_12_1 in pairs(arg_12_0.teachItemTab) do
		local var_12_1 = iter_12_1.config
		local var_12_2 = arg_12_0.Season166MO.teachInfoMap[var_12_1.teachId]
		local var_12_3 = arg_12_0.Season166MO.teachInfoMap[var_12_1.preTeachId]
		local var_12_4 = var_12_1.preTeachId == 0 or var_12_1.preTeachId > 0 and var_12_3 and var_12_3.passCount > 0
		local var_12_5 = not var_12_2 or not var_12_4
		local var_12_6 = var_12_2 and var_12_2.passCount > 0

		gohelper.setActive(iter_12_1.goLock, var_12_5)
		gohelper.setActive(iter_12_1.goFinish, var_12_6)

		local var_12_7 = arg_12_0.rewardWindowTab[var_12_1.teachId]
		local var_12_8 = var_12_7.rewardList

		for iter_12_2, iter_12_3 in pairs(var_12_8) do
			gohelper.setActive(iter_12_3.goGet, var_12_6)
		end

		gohelper.setActive(var_12_7.window, var_12_7.isShow)

		local var_12_9 = var_12_5 and string.format("season_teach_lv%d_locked", iter_12_0) or string.format("season_teach_lv%d", iter_12_0)

		UISpriteSetMgr.instance:setSeason166Sprite(iter_12_1.imageIcon, var_12_9, true)

		iter_12_1.isLock = var_12_5 and Season166Enum.LockState or Season166Enum.UnlockState

		if not var_12_5 and (not var_12_0[iter_12_0] or var_12_0[iter_12_0] == Season166Enum.LockState) then
			iter_12_1.anim:Play(UIAnimationName.Unlock, 0, 0)
		end
	end

	arg_12_0:saveUnlockState()
end

function var_0_0.saveUnlockState(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.teachItemTab) do
		local var_13_1 = string.format("%s|%s", iter_13_0, iter_13_1.isLock)

		table.insert(var_13_0, var_13_1)
	end

	local var_13_2 = cjson.encode(var_13_0)

	Season166Controller.instance:savePlayerPrefs(Season166Enum.TeachLockSaveKey, var_13_2)
end

function var_0_0.onClose(arg_14_0)
	arg_14_0:saveUnlockState()
end

function var_0_0.onDestroyView(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.teachItemTab) do
		iter_15_1.btnReward:RemoveClickListener()
		iter_15_1.btnClick:RemoveClickListener()
	end
end

return var_0_0

module("modules.common.utils.StringExtend", package.seeall)

function StringExtend.activateExtend()
end

if isDebugBuild then
	slot1 = string.split

	function string.split(slot0, slot1)
		if GameUtil.needLogInFightSceneUseStringFunc() then
			logError("战斗场景中不要用`string.split`, 用`FightStrUtil.getSplitCache`代替")
		end

		return uv0(slot0, slot1)
	end

	slot2 = string.splitToNumber

	function string.splitToNumber(slot0, slot1)
		if GameUtil.needLogInFightSceneUseStringFunc() then
			logError("战斗场景中不要用`string.splitToNumber`, 用`FightStrUtil.getSplitToNumberCache`代替")
		end

		return uv0(slot0, slot1)
	end
end

return slot0

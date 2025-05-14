module("modules.logic.room.utils.RoomWaveHelper", package.seeall)

return {
	getWaveList = function(arg_1_0, arg_1_1)
		local var_1_0 = 0
		local var_1_1 = true

		for iter_1_0, iter_1_1 in ipairs(arg_1_0) do
			if not iter_1_1 then
				var_1_1 = false
				var_1_0 = iter_1_0

				break
			end
		end

		if var_1_1 then
			return {
				RoomScenePreloader.ResEffectWaveList[6]
			}, {
				0
			}, {
				RoomScenePreloader.ResEffectWaveList[6]
			}
		end

		local var_1_2 = {}
		local var_1_3 = {}
		local var_1_4 = {}
		local var_1_5 = 0
		local var_1_6 = false
		local var_1_7 = var_1_0

		for iter_1_2 = var_1_0, var_1_0 + 5 do
			local var_1_8 = (iter_1_2 - 1) % 6 + 1
			local var_1_9 = arg_1_0[var_1_8]

			var_1_6 = var_1_6 or arg_1_1[var_1_8]

			if var_1_9 then
				var_1_5 = var_1_5 + 1
			end

			if (not var_1_9 or iter_1_2 == var_1_0 + 5) and var_1_5 > 0 then
				if var_1_6 then
					table.insert(var_1_2, RoomScenePreloader.ResEffectWaveWithRiverList[var_1_5])
					table.insert(var_1_4, RoomScenePreloader.ResEffectWaveWithRiverList[var_1_5])
				else
					table.insert(var_1_2, RoomScenePreloader.ResEffectWaveList[var_1_5])
					table.insert(var_1_4, RoomScenePreloader.ResEffectWaveList[var_1_5])
				end

				table.insert(var_1_3, var_1_7)
			end

			if not var_1_9 then
				var_1_7 = var_1_8 % 6 + 1
				var_1_5 = 0
				var_1_6 = false
			end
		end

		return var_1_2, var_1_3, var_1_2
	end
}

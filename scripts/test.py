import gym
import gym_ple
import numpy as np

pong = gym.make('Pong-v3')
water = gym.make('WaterWorld-v0')

stats = {'Mean': np.mean,
         'Std': np.std,
         'Min': np.min,
         'Max': np.max,
         'Sparsity': lambda x: (np.array(x)==0).mean(),
        }


def compute_stats(a):
    a = np.array(a)
    sparsity_length = np.split(a, np.where(a == 0.)[0][1:])
    return a.mean(), \
           a.std(), \
           a.min(), \
           a.max(), \
           (a==0).mean(), \
           np.mean([len(x) for x in sparsity_length]), \
           len(sparsity_length)

def rollout(env):
    env.reset()
    R = []
    done = False
    k = 0
    while not done:
        s, r, done, _ = env.step(env.action_space.sample())
        R.append(r)
        # print(round(r, 2))
        k += 1
    return R, k

N = 10

print("Water")
results = [rollout(water) for _ in range(N)]
rewards = [r[0] for r in results]
lengths = [r[1] for r in results]

import pdb; pdb.set_trace()

print("Total Return")
print(compute_stats(rewards[0]))

print('pong')
#R = np.array([rollout(pong) for _ in range(N)]).astype('float32')
#print(R)
# print_results(R)

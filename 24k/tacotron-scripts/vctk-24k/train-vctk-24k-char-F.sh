#!/bin/sh
#$ -cwd
#$ -l s_gpu=1
#$ -l h_rt=24:00:00
# ==============================================================================
# Copyright (c) 2020, Yamagishi Laboratory, National Institute of Informatics
# Author: Erica Cooper (ecooper@nii.ac.jp)
# All rights reserved.
# ==============================================================================

. /etc/profile.d/modules.sh
module load intel cuda/9.0.176 nccl/2.2.13 cudnn/7.3

export PATH="/home/7/18IA1182/miniconda3/bin:$PATH"
source activate tacotron2

export PYTHONPATH=/home/7/18IA1182/external:/home/7/18IA1182/external/tacotron2:/home/7/18IA1182/external/self_attention_tacotron:/home/7/18IA1182/external/multi_speaker_tacotron:$PYTHONPATH
export TF_FORCE_GPU_ALLOW_GROWTH=true

cd /home/7/18IA1182/external/self_attention_tacotron

python train.py --source-data-root=/gs/hs0/tgh-20IAA/ecooper/data/vctk_24k/source --target-data-root=/gs/hs0/tgh-20IAA/ecooper/data/vctk_24k/target_trimmed --checkpoint-dir=/gs/hs0/tgh-20IAA/ecooper/experiments/vctk-24k/char/F/checkpoint --selected-list-dir=/home/7/18IA1182/scps/vctk_selected_list/vctk_unseen_selected_list_fixed_F --hparams=num_freq=1025,sample_rate=24000,frame_shift_ms=12.0,mel_fmax=8000,tacotron_model="DualSourceSelfAttentionTacotronModel",encoder="SelfAttentionCBHGEncoder",decoder="DualSourceTransformerDecoder",initial_learning_rate=0.0001,decay_learning_rate=True,learning_rate_decay_method="exponential_bounded",min_learning_rate_if_bounded=1e-5,cbhg_out_units=512,use_accent_type=False,embedding_dim=512,encoder_prenet_out_units=[512,512],encoder_prenet_drop_rate=0.5,projection1_out_channels=512,projection2_out_channels=512,self_attention_out_units=64,self_attention_encoder_out_units=64,decoder_prenet_out_units=[256,256],decoder_out_units=1024,attention_out_units=128,attention1_out_units=128,attention2_out_units=64,decoder_self_attention_num_hop=2,decoder_self_attention_out_units=1024,outputs_per_step=2,max_iters=500,attention=forward,attention2=additive,cumulative_weights=False,attention_kernel=31,attention_filters=32,use_zoneout_at_encoder=True,decoder_version="v2",num_symbols=256,eval_throttle_secs=600,eval_start_delay_secs=120,num_evaluation_steps=200,keep_checkpoint_max=200,use_l2_regularization=True,l2_regularization_weight=1e-7,use_postnet_v2=True,batch_size=48,dataset="vctk.dataset.DatasetSource",save_checkpoints_steps=1683,target_file_extension="target.tfrecord",use_external_speaker_embedding=True,embedding_file="/gs/hs0/tgh-20IAA/ecooper/speaker_embeddings/vctk-lde.txt",speaker_embedding_dim='512',speaker_embedding_projection_out_dim=64,speaker_embedd_to_decoder=True,num_speakers=372,speaker_embedding_offset=5,source='character',logfile=/gs/hs0/tgh-20IAA/ecooper/experiments/vctk-24k/char/F/train.log --hparam-json-file=/gs/hs0/tgh-20IAA/ecooper/data/vctk_24k/target_trimmed/hparams.json

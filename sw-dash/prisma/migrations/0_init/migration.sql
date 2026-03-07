-- CreateTable
CREATE TABLE `users` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `slackId` VARCHAR(191) NOT NULL,
    `ftuid` VARCHAR(191) NULL,
    `username` VARCHAR(191) NOT NULL,
    `avatar` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `isActive` BOOLEAN NOT NULL DEFAULT true,
    `role` VARCHAR(191) NOT NULL DEFAULT 'observer',
    `sessionExpires` DATETIME(3) NULL,
    `sessionToken` VARCHAR(191) NULL,
    `currentChallenge` VARCHAR(191) NULL,
    `staffNotes` TEXT NULL,
    `skills` JSON NULL,
    `lastSeen` DATETIME(3) NULL,
    `cookieBalance` DOUBLE NOT NULL DEFAULT 0,
    `cookiesEarned` DOUBLE NOT NULL DEFAULT 0,
    `streak` INTEGER NOT NULL DEFAULT 0,
    `lastReviewDate` DATE NULL,
    `swApiKey` VARCHAR(64) NULL,

    UNIQUE INDEX `users_slackId_key`(`slackId`),
    UNIQUE INDEX `users_ftuid_key`(`ftuid`),
    UNIQUE INDEX `users_swApiKey_key`(`swApiKey`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `payout_reqs` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `amount` DOUBLE NOT NULL,
    `bonus` DOUBLE NOT NULL DEFAULT 0,
    `bonusReason` VARCHAR(191) NULL,
    `finalAmount` DOUBLE NULL,
    `balBefore` DOUBLE NOT NULL,
    `balAfter` DOUBLE NULL,
    `status` VARCHAR(191) NOT NULL DEFAULT 'pending',
    `adminId` INTEGER NULL,
    `proofUrl` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `approvedAt` DATETIME(3) NULL,

    INDEX `payout_reqs_userId_idx`(`userId`),
    INDEX `payout_reqs_status_idx`(`status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `push_subs` (
    `id` VARCHAR(191) NOT NULL,
    `userId` INTEGER NOT NULL,
    `endpoint` VARCHAR(1000) NOT NULL,
    `p256dh` VARCHAR(191) NOT NULL,
    `auth` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `push_subs_endpoint_key`(`endpoint`),
    INDEX `push_subs_userId_idx`(`userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sessions` (
    `id` VARCHAR(191) NOT NULL,
    `token` VARCHAR(191) NOT NULL,
    `userId` INTEGER NOT NULL,
    `device` VARCHAR(191) NULL,
    `ip` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `expiresAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `sessions_token_key`(`token`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `login_logs` (
    `id` VARCHAR(191) NOT NULL,
    `slackId` VARCHAR(191) NULL,
    `username` VARCHAR(191) NULL,
    `success` BOOLEAN NOT NULL,
    `ip` VARCHAR(191) NOT NULL,
    `userAgent` TEXT NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `assignments` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `repoUrl` TEXT NOT NULL,
    `description` VARCHAR(191) NULL,
    `status` VARCHAR(191) NOT NULL DEFAULT 'pending',
    `comments` TEXT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `assigneeId` INTEGER NULL,
    `projectName` VARCHAR(191) NULL,
    `demoUrl` TEXT NULL,
    `shipCertId` INTEGER NULL,

    UNIQUE INDEX `assignments_shipCertId_key`(`shipCertId`),
    INDEX `assignments_assigneeId_idx`(`assigneeId`),
    INDEX `assignments_userId_idx`(`userId`),
    INDEX `assignments_shipCertId_idx`(`shipCertId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `assign_subsc` (
    `id` VARCHAR(191) NOT NULL,
    `userId` INTEGER NOT NULL,
    `assignmentId` INTEGER NOT NULL,
    `isSubscribed` BOOLEAN NOT NULL DEFAULT true,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `assign_subsc_assignmentId_idx`(`assignmentId`),
    UNIQUE INDEX `assign_subsc_userId_assignmentId_key`(`userId`, `assignmentId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ship_certs` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `ftProjectId` VARCHAR(191) NULL,
    `ftSlackId` VARCHAR(191) NULL,
    `ftUsername` VARCHAR(191) NULL,
    `ftType` VARCHAR(191) NULL,
    `projectName` VARCHAR(191) NULL,
    `projectType` VARCHAR(191) NULL,
    `description` TEXT NULL,
    `demoUrl` TEXT NULL,
    `repoUrl` TEXT NULL,
    `readmeUrl` TEXT NULL,
    `devTime` VARCHAR(191) NULL,
    `status` VARCHAR(191) NOT NULL DEFAULT 'pending',
    `reviewerId` INTEGER NULL,
    `claimerId` INTEGER NULL,
    `internalNotes` TEXT NULL,
    `reviewFeedback` TEXT NULL,
    `proofVideoUrl` VARCHAR(191) NULL,
    `reviewStartedAt` DATETIME(3) NULL,
    `reviewCompletedAt` DATETIME(3) NULL,
    `syncedToFt` BOOLEAN NOT NULL DEFAULT false,
    `cookiesEarned` DOUBLE NULL,
    `payoutMulti` DOUBLE NULL,
    `customBounty` DOUBLE NULL,
    `aiSummary` TEXT NULL,
    `yswsReturnReason` TEXT NULL,
    `yswsReturnedBy` VARCHAR(191) NULL,
    `yswsReturnedAt` DATETIME(3) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `spotChecked` BOOLEAN NOT NULL DEFAULT false,
    `spotCheckedAt` DATETIME(3) NULL,
    `spotCheckedBy` INTEGER NULL,
    `spotPassed` BOOLEAN NULL,
    `spotRemoved` BOOLEAN NOT NULL DEFAULT false,

    INDEX `ship_certs_reviewerId_idx`(`reviewerId`),
    INDEX `ship_certs_status_idx`(`status`),
    INDEX `ship_certs_ftSlackId_idx`(`ftSlackId`),
    INDEX `ship_certs_projectType_idx`(`projectType`),
    INDEX `ship_certs_ftProjectId_idx`(`ftProjectId`),
    INDEX `ship_certs_status_createdAt_idx`(`status`, `createdAt`),
    INDEX `ship_certs_status_projectType_idx`(`status`, `projectType`),
    INDEX `ship_certs_status_yswsReturnedAt_createdAt_idx`(`status`, `yswsReturnedAt`, `createdAt`),
    INDEX `ship_certs_status_reviewCompletedAt_reviewerId_idx`(`status`, `reviewCompletedAt`, `reviewerId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ft_submitter_notes` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `slackId` VARCHAR(191) NOT NULL,
    `staffId` INTEGER NOT NULL,
    `text` TEXT NOT NULL,
    `certId` INTEGER NULL,
    `ticketId` INTEGER NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `ft_submitter_notes_slackId_idx`(`slackId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ysws_reviews` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `shipCertId` INTEGER NOT NULL,
    `status` VARCHAR(191) NOT NULL DEFAULT 'pending',
    `reviewerId` INTEGER NULL,
    `returnReason` TEXT NULL,
    `devlogs` JSON NULL,
    `commits` JSON NULL,
    `decisions` JSON NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `ysws_reviews_shipCertId_idx`(`shipCertId`),
    INDEX `ysws_reviews_status_idx`(`status`),
    INDEX `ysws_reviews_reviewerId_idx`(`reviewerId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `yubikeys` (
    `id` VARCHAR(191) NOT NULL,
    `userId` INTEGER NOT NULL,
    `credentialId` VARCHAR(191) NOT NULL,
    `publicKey` LONGBLOB NOT NULL,
    `counter` BIGINT NOT NULL,
    `transports` VARCHAR(191) NULL,
    `name` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `lastUsedAt` DATETIME(3) NULL,

    UNIQUE INDEX `yubikeys_credentialId_key`(`credentialId`),
    INDEX `yubikeys_userId_idx`(`userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `audit_logs` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `adminId` INTEGER NOT NULL,
    `action` VARCHAR(191) NOT NULL,
    `details` TEXT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `audit_logs_adminId_idx`(`adminId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tickets` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` VARCHAR(50) NOT NULL,
    `userName` VARCHAR(255) NOT NULL,
    `question` TEXT NOT NULL,
    `userThreadTs` VARCHAR(50) NOT NULL,
    `staffThreadTs` VARCHAR(50) NOT NULL,
    `status` ENUM('open', 'closed') NULL DEFAULT 'open',
    `createdAt` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `closedAt` TIMESTAMP(0) NULL,
    `closedBy` VARCHAR(50) NULL,
    `userAvatar` VARCHAR(500) NULL,
    `assignees` TEXT NULL,

    INDEX `tickets_staffThreadTs_idx`(`staffThreadTs`),
    INDEX `tickets_userThreadTs_idx`(`userThreadTs`),
    INDEX `tickets_closedBy_idx`(`closedBy`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ticket_feedback` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `ticketId` INTEGER NOT NULL,
    `rating` INTEGER NOT NULL,
    `comment` VARCHAR(250) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `ticket_feedback_ticketId_idx`(`ticketId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ticket_users` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` VARCHAR(50) NOT NULL,
    `isOptedIn` BOOLEAN NOT NULL DEFAULT true,

    UNIQUE INDEX `ticket_users_userId_key`(`userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `metrics_history` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `output` JSON NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ticket_msgs` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `ticketId` INTEGER NOT NULL,
    `senderId` VARCHAR(50) NOT NULL,
    `senderName` VARCHAR(255) NOT NULL,
    `msg` TEXT NOT NULL,
    `files` LONGTEXT NULL,
    `isStaff` BOOLEAN NULL DEFAULT false,
    `createdAt` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `senderAvatar` VARCHAR(500) NULL,
    `messageTs` VARCHAR(50) NULL,
    `originMessageTs` VARCHAR(50) NULL,

    INDEX `ticket_msgs_ticketId_idx`(`ticketId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ticket_notes` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `ticketId` INTEGER NOT NULL,
    `authorId` INTEGER NOT NULL,
    `text` TEXT NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `ticket_notes_ticketId_idx`(`ticketId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sys_logs` (
    `id` VARCHAR(191) NOT NULL,
    `userId` INTEGER NULL,
    `slackId` VARCHAR(191) NULL,
    `username` VARCHAR(191) NULL,
    `role` VARCHAR(191) NULL,
    `action` VARCHAR(191) NOT NULL,
    `context` TEXT NULL,
    `statusCode` INTEGER NOT NULL,
    `ip` VARCHAR(191) NULL,
    `userAgent` TEXT NULL,
    `email` VARCHAR(191) NULL,
    `avatar` VARCHAR(191) NULL,
    `targetId` INTEGER NULL,
    `targetType` VARCHAR(191) NULL,
    `metadata` JSON NULL,
    `severity` VARCHAR(191) NULL DEFAULT 'info',
    `reqMethod` VARCHAR(191) NULL,
    `reqUrl` TEXT NULL,
    `reqBody` JSON NULL,
    `reqHeaders` JSON NULL,
    `resStatus` INTEGER NULL,
    `resBody` JSON NULL,
    `resHeaders` JSON NULL,
    `errorName` VARCHAR(191) NULL,
    `errorMsg` TEXT NULL,
    `errorStack` TEXT NULL,
    `changes` JSON NULL,
    `duration` INTEGER NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `sys_logs_userId_idx`(`userId`),
    INDEX `sys_logs_action_idx`(`action`),
    INDEX `sys_logs_createdAt_idx`(`createdAt`),
    INDEX `sys_logs_ip_idx`(`ip`),
    INDEX `sys_logs_severity_idx`(`severity`),
    INDEX `sys_logs_targetType_idx`(`targetType`),
    INDEX `sys_logs_targetType_targetId_idx`(`targetType`, `targetId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `spot_checks` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `caseId` VARCHAR(191) NOT NULL,
    `certId` INTEGER NOT NULL,
    `staffId` INTEGER NOT NULL,
    `reviewerId` INTEGER NOT NULL,
    `decision` VARCHAR(191) NOT NULL,
    `status` VARCHAR(191) NOT NULL DEFAULT 'unresolved',
    `notes` TEXT NULL,
    `reasoning` TEXT NULL,
    `lbRemoved` BOOLEAN NOT NULL DEFAULT false,
    `fpReason` TEXT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `resolvedAt` DATETIME(3) NULL,
    `resolvedBy` INTEGER NULL,

    UNIQUE INDEX `spot_checks_caseId_key`(`caseId`),
    INDEX `spot_checks_certId_idx`(`certId`),
    INDEX `spot_checks_staffId_idx`(`staffId`),
    INDEX `spot_checks_reviewerId_idx`(`reviewerId`),
    INDEX `spot_checks_status_idx`(`status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `payout_reqs` ADD CONSTRAINT `payout_reqs_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `payout_reqs` ADD CONSTRAINT `payout_reqs_adminId_fkey` FOREIGN KEY (`adminId`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `push_subs` ADD CONSTRAINT `push_subs_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `sessions` ADD CONSTRAINT `sessions_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `assignments` ADD CONSTRAINT `assignments_assigneeId_fkey` FOREIGN KEY (`assigneeId`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `assignments` ADD CONSTRAINT `assignments_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `assignments` ADD CONSTRAINT `assignments_shipCertId_fkey` FOREIGN KEY (`shipCertId`) REFERENCES `ship_certs`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `assign_subsc` ADD CONSTRAINT `assign_subsc_assignmentId_fkey` FOREIGN KEY (`assignmentId`) REFERENCES `assignments`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `assign_subsc` ADD CONSTRAINT `assign_subsc_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ship_certs` ADD CONSTRAINT `ship_certs_reviewerId_fkey` FOREIGN KEY (`reviewerId`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ship_certs` ADD CONSTRAINT `ship_certs_claimerId_fkey` FOREIGN KEY (`claimerId`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ft_submitter_notes` ADD CONSTRAINT `ft_submitter_notes_staffId_fkey` FOREIGN KEY (`staffId`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ysws_reviews` ADD CONSTRAINT `ysws_reviews_shipCertId_fkey` FOREIGN KEY (`shipCertId`) REFERENCES `ship_certs`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ysws_reviews` ADD CONSTRAINT `ysws_reviews_reviewerId_fkey` FOREIGN KEY (`reviewerId`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `yubikeys` ADD CONSTRAINT `yubikeys_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `audit_logs` ADD CONSTRAINT `audit_logs_adminId_fkey` FOREIGN KEY (`adminId`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ticket_msgs` ADD CONSTRAINT `ticket_msgs_ticketId_fkey` FOREIGN KEY (`ticketId`) REFERENCES `tickets`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `ticket_notes` ADD CONSTRAINT `ticket_notes_ticketId_fkey` FOREIGN KEY (`ticketId`) REFERENCES `tickets`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ticket_notes` ADD CONSTRAINT `ticket_notes_authorId_fkey` FOREIGN KEY (`authorId`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `spot_checks` ADD CONSTRAINT `spot_checks_certId_fkey` FOREIGN KEY (`certId`) REFERENCES `ship_certs`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `spot_checks` ADD CONSTRAINT `spot_checks_staffId_fkey` FOREIGN KEY (`staffId`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `spot_checks` ADD CONSTRAINT `spot_checks_reviewerId_fkey` FOREIGN KEY (`reviewerId`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `spot_checks` ADD CONSTRAINT `spot_checks_resolvedBy_fkey` FOREIGN KEY (`resolvedBy`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

